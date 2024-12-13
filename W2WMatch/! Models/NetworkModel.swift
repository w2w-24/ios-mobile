//
//  NetworkModel.swift
//  W2WMatch
//
//  Created by Floron on 07.06.2024.
//

import Foundation

enum ApiUrlChooser {
    case authorization, registration
}

class NetworkModel {
    
    private let domen = "server.w2w"
    
    // Artem, uncomment next line and comment previous line
    // private let domen = "192.168.0.67:8000"
    
    func serverRequest(apiToUse: ApiUrlChooser, user: UserModel, completion: @escaping (Int, [String: Any])->()) {
        
        var apiUrl = ""
        var json: [String: Any] = [:]
        
        switch apiToUse {
        case .authorization:
            apiUrl = "http://\(domen)/auth/jwt/create/"
            json = ["email": "\(user.email)",
                    "password": "\(user.password)"]
        case .registration:
            apiUrl = "http://\(domen)/auth/users/"
            json = ["email": "\(user.email)",
                    "phone": "\(user.phone)",
                    "password": "\(user.password)"]
        }
        

        
        guard let unwrApiUrl = URL(string: apiUrl) else { return }
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        //let url = URL(string: "http://localhost:1337/postrequest/addData")! //PUT Your URL
        var request = URLRequest(url: unwrApiUrl)
        request.httpMethod = "POST"
        request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // insert json data to the request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            //print("data: \(data)    response: \(response)   error: \(error)")
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data)
            guard let responseJSON = responseJSON as? [String: Any] else { return }
            
//            print(apiUrl)
            print(responseJSON) //Code after Successfull POST Request
                
            
            let httpResponse = response as? HTTPURLResponse
            guard let httpResponse = httpResponse else { return }
            
            if httpResponse.statusCode == 200 {
                if let refreshToken = responseJSON["refresh"] as? String {
                    user.refreshToken = refreshToken
                    
                    guard let expTokensTime = try? TokenDecoder.shared.decode(jwtToken: refreshToken) else { return }
                    
                    print("Exp time: ", expTokensTime)
                }
                
                if let accessToken = responseJSON["access"] as? String {
                    user.accessToken = accessToken
                    
                    guard let expTokensTime = try? TokenDecoder.shared.decode(jwtToken: accessToken) else { return }
                    
                    print("Exp time: ", expTokensTime)
//                    print("=======      Access token!  =======")
//                    if let decodedToken = try? self.decode(jwtToken: accessToken) {
//                        print(decodedToken)
//                        guard let decodedToken = decodedToken as? [String: Any] else { return }
//                        if let expTokensTime = decodedToken["exp"] as? String {
//                            print("Exp time: ", expTokensTime)
//                        }
//                    }
                }
                
                //print("access Token: \(user.accessToken)        refresh Token: \(user.refreshToken)")
            } else {
                
            }
                        
//            print(responseJSON.keys)
//            print("==========    Current status code: \(httpResponse.statusCode)")
            
            completion(httpResponse.statusCode, responseJSON)
        }
        task.resume()
    }
}
