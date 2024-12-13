//
//  TokenDecoder.swift
//  jwt_authorizer
//
//  Created by Floron on 14.06.2024.
//

import Foundation

class TokenDecoder {
    
    static let shared = TokenDecoder()
    
    func decode(jwtToken jwt: String) throws -> Int64 {
        
        let segments = jwt.components(separatedBy: ".")
        
        enum DecodeErrors: Error {
            case badToken
            case other
        }
        
        func base64Decode(_ base64: String) throws -> Data {
            let base64 = base64
                .replacingOccurrences(of: "-", with: "+")
                .replacingOccurrences(of: "_", with: "/")
            let padded = base64.padding(toLength: ((base64.count + 3) / 4) * 4, withPad: "=", startingAt: 0)
            guard let decoded = Data(base64Encoded: padded) else {
                throw DecodeErrors.badToken
            }
            return decoded
        }
        
        func decodeJWTPart(_ value: String) throws -> [String: Any] {
            let bodyData = try base64Decode(value)
            let json = try JSONSerialization.jsonObject(with: bodyData)
            guard let payload = json as? [String: Any] else {
                throw DecodeErrors.other
            }
            return payload
        }
        
        func giveMeExpTime() throws -> Int64 {
            print("=======      Token found !  =======")
            
            let decodedToken = try decodeJWTPart(segments[1])
            
            guard let expTokensTime = decodedToken["exp"] as? Int64 else {
                throw DecodeErrors.other
            }
            
            return expTokensTime
        }
        
        return try giveMeExpTime()
    }
    
}
