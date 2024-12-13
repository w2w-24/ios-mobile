//
//  Endpoint.swift
//  jwt_authorizer
//
//  Created by Lev Baklanov on 27.10.2022.
//

import Foundation

enum Endpoint {
    
    static let baseURL: String  = "http://localhost/"

    case register
    case login
    case refreshTokens
    case myBrand
    case getAnketa
    case paymentList
    
    func path() -> String {
        switch self {
        case .register:
            return "auth/users/"
        case .login:
            return "auth/jwt/create/"
        case .refreshTokens:
            return "auth/jwt/refresh/"
        case .myBrand:
            return "api/v1/brand/"
        case .getAnketa:
            return "api/v1/questionnaire/"
        case .paymentList:
            return "api/v1/payment/"
        }
    }
    
    var absoluteURL: URL {
        URL(string: Endpoint.baseURL + self.path())!
    }
}
