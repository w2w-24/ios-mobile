//
//  Requester.swift
//  jwt_authorizer
//
//  Created by Lev Baklanov on 27.10.2022.
//

import Foundation

class Requester {
    
    static let shared = Requester()
    static private let ACCESS_TOKEN_LIFE_THRESHOLD_SECONDS: Int64 = 10
    
    private var accessToken = UserDefaultsWorker.shared.getAccessToken()
    private var refreshToken = UserDefaultsWorker.shared.getRefreshToken()
    
    private init() {}
    
    private func onTokensRefreshed (tokens: TokensInfo) {
        UserDefaultsWorker.shared.saveAuthTokens(tokens: tokens)
        accessToken = TokenInfo(token: tokens.accessToken, expiresAt: tokens.accessTokenExpire)
        print("accessToken Refreshed: ", accessToken)
        refreshToken = TokenInfo(token: tokens.refreshToken, expiresAt: tokens.refreshTokenExpire)
        print("refreshToken Refreshed: ", refreshToken)
    }
    
    func dropTokens() {
        accessToken = TokenInfo(token: "", expiresAt: 0)
        refreshToken = TokenInfo(token: "", expiresAt: 0)
    }
    
    private func formRequest (url: URL,
                              data: Data = Data(),
                              method: String = "POST",
                              contentType: String = "application/json",
                              refreshTokens: Bool = false,
                              ignoreJwtAuth: Bool = false) -> URLRequest {
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        request.httpMethod = method
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
//        if refreshTokens {
//            request.addValue("\(refreshToken.token)", forHTTPHeaderField: "refresh")
//        } else 
        if !accessToken.token.isEmpty && !ignoreJwtAuth {
            request.addValue("Bearer \(accessToken.token)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
    
    // запрос к апи для обновления токенов
    private func formRefreshTokensRequest() -> URLRequest {
        let url = Endpoint.refreshTokens.absoluteURL
        let refresh: [String: String] = ["refresh": "\(refreshToken.token)"]
        let body = try! JSONEncoder().encode(refresh)
//        let decodedBody = try? JSONSerialization.jsonObject(with: body)
//       
        //print("body for request new tokens: ", decodedBody)
        let request = formRequest(url: url, data: body)
        return request
    }
    
    private func renewAuthHeader (request: URLRequest) -> URLRequest {
        var newRequest = request
        newRequest.setValue("Bearer \(accessToken.token)", forHTTPHeaderField: "Authorization")
        return newRequest
    }
    
    // проверка валидности токенов
    private var needReAuth: Bool {
        let current = Date().timestampMillis()
        let expires = accessToken.expiresAt
        return current + Requester.ACCESS_TOKEN_LIFE_THRESHOLD_SECONDS > expires
    }
    
    // MARK: - handle... эти методы при успешной авторизации или регистрации обновляют jwt токены
    private func handleAuthResponse (response: Result<ResponseAuthTokens>, onResult: @escaping (Result<ResponseAuthTokens>) -> Void) {
        if case .success(let serverResponse) = response {
            self.onTokensRefreshed(tokens: serverResponse.getTokensInfo())
        }
        onResult(response)
    }
    
    private func handleRegisterResponse (authBody: AuthBody, response: Result<ResponseRegister>, onResult: @escaping (Result<ResponseRegister>) -> Void) {
        if case .success(_) = response {
            login(authBody: authBody) { result in
                if case .success(let authResponse) = result {
                    self.onTokensRefreshed(tokens: authResponse.getTokensInfo())
                }
            }
        }
        onResult(response)
    }
    
    func register (authBody: AuthBody, onResult: @escaping (Result<ResponseRegister>) -> Void) {
        let url = Endpoint.register.absoluteURL
        let body = try! JSONEncoder().encode(authBody) //TODO: handle serializaztion error
        let request = formRequest(url: url, data: body, ignoreJwtAuth: true)
        self.doRequest(request: request) { [self] result in
            self.handleRegisterResponse(authBody: authBody, response: result, onResult: onResult)
        }
    }
    
    func login (authBody: AuthBody, onResult: @escaping (Result<ResponseAuthTokens>) -> Void) {
        let url = Endpoint.login.absoluteURL
        let body = try! JSONEncoder().encode(authBody) //TODO: handle serializaztion error
        let request = formRequest(url: url, data: body, ignoreJwtAuth: true)
        self.doRequest(request: request) { [self] result in
            self.handleAuthResponse(response: result, onResult: onResult)
        }
    }
    
    func brandCreate (authBody: CreateBrandRequestBody, onResult: @escaping (Result<CreateBrandResponse>) -> Void) {
        let url = Endpoint.myBrand.absoluteURL
        let body = try! JSONEncoder().encode(authBody) //TODO: handle serializaztion error
        let request = formRequest(url: url, data: body)
        self.request(request: request, onResult: onResult)
    }
    
    func getAllBrands (onResult: @escaping (Result<[CreateBrandResponse]>) -> Void) {
        let url = Endpoint.myBrand.absoluteURL
        let request = formRequest(url: url, method: "GET", ignoreJwtAuth: true)
        self.request(request: request, ignoreJwtAuth: true, onResult: onResult)
    }
    
    func getAnketa (onResult: @escaping (Result<[AnketaElement]>) -> Void) {
        let url = Endpoint.getAnketa.absoluteURL
        let request = formRequest(url: url, method: "GET", ignoreJwtAuth: true)
        self.request(request: request, ignoreJwtAuth: true, onResult: onResult)
    }
    
    func getPaymentList (onResult: @escaping (Result<[PaymentListElement]>) -> Void) {
        let url = Endpoint.paymentList.absoluteURL
        let request = formRequest(url: url, method: "GET", ignoreJwtAuth: true)
        self.request(request: request, ignoreJwtAuth: true, onResult: onResult)
    }
    
//    func getDevelopers(onResult: @escaping (Result<[Developer]>) -> Void) {
//        let url = Endpoint.getDevelopers.absoluteURL
//        let request = formRequest(url: url, data: Data(), method: "GET")
//        self.request(request: request, onResult: onResult)
//    }
    
    func request<T: Decodable> (request: URLRequest, ignoreJwtAuth: Bool = false, onResult: @escaping (Result<T>) -> Void) {
        print("request called")
        if (needReAuth && !refreshToken.token.isEmpty && !ignoreJwtAuth) {
            print("need to re-auth")
            authAndDoRequest(request: request, onResult: onResult)
        } else {
            print("no need to re-auth")
            doRequest(request: request, onResult: onResult)
        }
    }
    
    func authAndDoRequest<T: Decodable> (request: URLRequest, onResult: @escaping (Result<T>) -> Void) {
        let refreshRequest = formRefreshTokensRequest()
        
        let task = URLSession.shared.dataTask(with: refreshRequest) { [self] (data, response, error) -> Void in
            if let error = error {
                print("error refresh tokens: ", error)
                DispatchQueue.main.async { onResult(.networkError(error.localizedDescription)) }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                //should never happen
                DispatchQueue.main.async {
                    onResult(.authError(ErrorResponse(code: 0, message: Errors.ERR_CONVERTING_TO_HTTP_RESPONSE)))
                }
                return
            }
            guard let data = data else {
                //should never happen
                DispatchQueue.main.async {
                    onResult(.authError(ErrorResponse(code: httpResponse.statusCode, message: Errors.ERR_NIL_BODY)))
                }
                return
            }
            
            if httpResponse.isSuccessful() {
                do {
                    let response = try JSONDecoder().decode(ResponseAuthTokens.self, from: data)
                    print("parsed refresh response: \(response)")
                    onTokensRefreshed(tokens: response.getTokensInfo())
                    print("saved new tokens, now doing request: \(request.url?.absoluteString ?? "")")
                    let newRequest = renewAuthHeader(request: request)
                    doRequest(request: newRequest, onResult: onResult)
                    return
                } catch {
                    DispatchQueue.main.async {
                        //should never happen
                        onResult(.authError(ErrorResponse(code: 0, message: Errors.ERR_PARSE_RESPONSE)))
                    }
                    return
                }
            } else {
                print("refresh tokens not successful")
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    print("error refresh tokens: ", errorResponse)
                    DispatchQueue.main.async {
                        onResult(.authError(errorResponse))
                    }
                    return
                } catch {
                    DispatchQueue.main.async {
                        onResult(.authError(ErrorResponse(code: 0, message: error.localizedDescription)))
                    }
                    return
                }
            }
        }
        task.resume()
    }
    
    func doRequest<T: Decodable> (request: URLRequest, onResult: @escaping (Result<T>) -> Void) {
        print("do request \(request.url?.absoluteString ?? "")")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            if let error = error {
                print("response error: ", error)
                DispatchQueue.main.async { onResult(.networkError(error.localizedDescription)) }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                //should never happen
                DispatchQueue.main.async { onResult(.networkError(Errors.ERR_CONVERTING_TO_HTTP_RESPONSE)) }
                return
            }
            
            guard let data = data else {
                //should never happen
                DispatchQueue.main.async {
                    onResult(.serverError(ErrorResponse(code: httpResponse.statusCode, message: Errors.ERR_NIL_BODY)))
                }
                return
            }
            
            
            print("=================   http Response Body    ===================")
            let responseJSON = try? JSONSerialization.jsonObject(with: data)
            
           // guard let responseJSON = responseJSON as? [String: Any] else { return }
            guard let responseJSON = responseJSON else { return }
            
            print(responseJSON) //Code after Successfull POST Request
            print("=========================  end  ============================")
            
            
            print("respone code: \(httpResponse.statusCode)")
            if httpResponse.isSuccessful() {
                let responseBody: Result<T> = self.parseResponse(data: data)
                DispatchQueue.main.async { onResult(responseBody) }
            } else {
                let responseBody: Result<T> = self.parseError(data: data)
                DispatchQueue.main.async { onResult(responseBody) }
            }
        }
        task.resume()
    }
    
    // обработчик ответа от апи
    private func parseResponse<T: Decodable> (data: Data) -> Result<T> {
        do {
            return .success(try JSONDecoder().decode(T.self, from: data))
        } catch {
            print("failed parsing successful response, parsing err: \(error)")
            return parseError(data: data)
        }
    }
    
    // обработчик ответа ошибки от апи
    private func parseError<T> (data: Data) -> Result<T> {
        print("parsing error")
        do {
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            if (errorResponse.isAuth()) {
                return .authError(errorResponse)
            } else {
                return .serverError(errorResponse)
            }
        } catch {
            return .serverError(ErrorResponse(code: 0, message: Errors.ERR_PARSE_ERROR_RESPONSE))
        }
    }
}
