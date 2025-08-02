//
//  postSignIn.swift
//  SCMP_Assignment
//
//  Created by James on 2/8/2025.
//

import Foundation

struct SignInResponse: Codable, NetworkResponse {
    let token: String?
    
    enum CodingKeys: String, CodingKey {
        case token = "token"
    }
}

extension NetworkRequest where ResponseType == SignInResponse {
    static func signIn(email: String, password: String) -> NetworkRequest<SignInResponse> {
        let urlString = "https://reqres.in/api/login?delay=5"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        
        return NetworkRequest<SignInResponse>(
            method: .post,
            url: url,
            headers: [
                "x-api-key": "reqres-free-v1"
            ],
            body: [
                "email": email,
                "password": password
            ],
            requestType: .json
        )
    }
}
