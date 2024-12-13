//
//  AuthAndRegistrationResponseModels.swift
//  W2WMatch
//
//  Created by Floron on 15.06.2024.
//

import Foundation

struct ResponseAuthTokens: Codable {
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access"
        case refreshToken = "refresh"
    }
    
    func getTokensInfo() -> TokensInfo {
        guard let accessTokenExpire = try? TokenDecoder.shared.decode(jwtToken: accessToken) else { return TokensInfo(accessToken: "", accessTokenExpire: 0, refreshToken: "", refreshTokenExpire: 0) }
        
        guard let refreshTokenExpire = try? TokenDecoder.shared.decode(jwtToken: refreshToken) else { return TokensInfo(accessToken: "", accessTokenExpire: 0, refreshToken: "", refreshTokenExpire: 0) }
        
        return TokensInfo(accessToken: accessToken,
                          accessTokenExpire: accessTokenExpire * 1000,
                          refreshToken: refreshToken,
                          refreshTokenExpire: refreshTokenExpire * 1000)
    }
}


struct ResponseRegister: Codable {
    let id: Int64
    let email: String
    let phone: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case email = "email"
        case phone = "phone"
    }
}


// request for auth and registration
struct AuthBody: Codable {
    let email: String
    let password: String
    let phone: String
}
