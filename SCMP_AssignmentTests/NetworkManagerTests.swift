//
//  Untitled.swift
//  SCMP_Assignment
//
//  Created by James on 2/8/2025.
//

import Testing
import Foundation

@testable import SCMP_Assignment

@Suite("Network Manager Tests")
struct NetworkManagerTests {
    let mockNetworkManager = MockNetworkManager()
    
    @Test("Sign in succeeds and returns token")
    func testSignInSuccess() async throws {
        mockNetworkManager.shouldSucceed = true
        mockNetworkManager.mockToken = "QpwL5tke4Pnpja7X4"
        let request = Request.signIn(email: "eve.holt@reqres.in", password: "cityslicka")
        
        let token = try await mockNetworkManager.performRequest(request)
        
        #expect(token == "QpwL5tke4Pnpja7X4")
    }
    
    @Test("Sign in fails and throws error")
    func testSignInFailure() async throws {
        mockNetworkManager.shouldSucceed = false
        mockNetworkManager.mockError = URLError(.badServerResponse)
        let request = Request.signIn(email: "eve.holt@reqres.in", password: "cityslicka")
        
        await #expect(throws: URLError.self) {
            _ = try await mockNetworkManager.performRequest(request)
        }
    }
}
