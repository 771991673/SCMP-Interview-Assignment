//
//  MockNetworkManager.swift
//  SCMP_Assignment
//
//  Created by James on 2/8/2025.
//

import Foundation
@testable import SCMP_Assignment

protocol NetworkManagerProtocol {
    func performRequest(_ request: Request) async throws -> String
}


class MockNetworkManager: NetworkManagerProtocol {
    var shouldSucceed: Bool = true
    var mockToken: String = "QpwL5tke4Pnpja7X4"
    var mockError: Error = URLError(.badServerResponse)
    
    func performRequest(_ request: Request) async throws -> String {
        if shouldSucceed {
            return mockToken
        } else {
            throw mockError
        }
    }
}

// Request.swift (example)
enum Request {
    case signIn(email: String, password: String)
    
    var url: URL {
        switch self {
        case .signIn:
            return URL(string: "https://reqres.in/api/login")!
        }
    }
}

struct TokenResponse: Codable {
    let token: String
}
