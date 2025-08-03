//
//  NetworkManager.swift
//  SCMP_Assignment
//
//  Created by James on 2/8/2025.
//

import Foundation
import Combine
import SwiftUI

public protocol NetworkResponse: Codable, Encodable { }

extension Array: NetworkResponse where Element : NetworkResponse { }

public struct NetworkRequest<ResponseType: NetworkResponse> {
    let method: HTTPMethod
    let url: URL
    var headers: [String: String]?
    var body: [String: Any]?
    var boundary: String?
    var requestType: RequestType?
    
}

public extension NetworkRequest {
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case delete = "DELETE"
        case put = "PUT"
    }
    
    enum RequestType: String {
        case form
        case json
    }
}

public enum NetworkError: Error {
    case httpError(statusCode: Int)
    case decodingError(Error)
}


public class NetworkManager {
    static let shared = NetworkManager()
    private let session: URLSession
    
    init() {
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }
    
    func performRequest<ResponseType: NetworkResponse>(_ request: NetworkRequest<ResponseType>, showLoading: Bool = true) async throws -> ResponseType {
        
        UIManager.shared.showLoading()
        
        defer { UIManager.shared.hideLoading() }
        
        var finalURL = request.url
        if let body = request.body as? [String: String], ["GET", "HEAD", "DELETE"].contains(request.method.rawValue.uppercased()) {
            var components = URLComponents(url: request.url, resolvingAgainstBaseURL: false)!
            components.queryItems = body.map { URLQueryItem(name: $0.key, value: $0.value) }
            finalURL = components.url!
        }
        
        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = request.method.rawValue.uppercased()
        
        urlRequest.setValue("*/*", forHTTPHeaderField: "accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        for (key, value) in request.headers ?? [:] {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        if let type = request.requestType {
            switch type {
            case .form:
                urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            case .json:
                break
            }
        }
        
        if !["GET", "HEAD", "DELETE"].contains(request.method.rawValue.uppercased()), let body = request.body {
            if request.requestType == .form {
                if let bodyDict = body as? [String: String] {
                    var components = URLComponents()
                    components.queryItems = bodyDict.map { URLQueryItem(name: $0.key, value: $0.value) }
                    if let query = components.percentEncodedQuery {
                        urlRequest.httpBody = query.data(using: .utf8)
                    }
                }
            } else {
                if let bodyData = try? JSONSerialization.data(withJSONObject: body) {
                    urlRequest.httpBody = bodyData
                }
            }
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(ResponseType.self, from: data)
        
        return result
    }
    
    
}
