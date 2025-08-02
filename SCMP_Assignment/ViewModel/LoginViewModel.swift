//
//  LoginViewModel.swift
//  SCMP_Assignment
//
//  Created by James on 2/8/2025.
//

import Combine
import Foundation

class LoginViewModel: ObservableObject {
    private let router: Router

    @Default(\.signInState) var signInState

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String? {
        didSet {
            if let errorMessage = errorMessage {
                UIManager.shared.showToast(message: errorMessage)
            }
        }
    }
    
    
    init(router: Router) {
        self.router = router
    }
    
    func validateEmail() -> Bool {
            let emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
            let isValidEmail = email.range(of: emailRegex, options: .regularExpression) != nil
            
            if isValidEmail {
                errorMessage = nil
                return true
            } else {
                errorMessage = "Enter a valid email"
                return false
            }
        }
    
    
    func validatePassword() -> Bool {
            let passwordRegex = "^[a-zA-Z0-9]{6,10}$"
            let isValidPasswords = password.range(of: passwordRegex, options: .regularExpression) != nil
            if isValidPasswords {
                errorMessage = nil
                return true
            } else {
                errorMessage = "Password must be 6–10 alphanumeric characters"
                return false
            }
        }
    
    func login() async {
            var success = false

            if email.isEmpty || password.isEmpty {
                errorMessage = "Please fill in all fields"
                success = false
            } else if validateEmail() && validatePassword() {
                do {
                    let token =  try await NetworkManager.shared.performRequest(.signIn(email: email, password: password))
                    
                    if let token = token.token {
                        _ = KeychainHelper.saveJWT(token, forKey: "token")
                    }
                    signInState = .signIn
                    errorMessage = nil
                    success = true
                    debugPrint(token)
                } catch {
                    signInState = .signedOut
                    errorMessage = "Network Error: \(error.localizedDescription)"
                    success = false
                }
            }
            
            if success {
                router.push(.staffList)
            }
    }
    
    func autoLogin() {
        if signInState == .signIn {
            router.push(.staffList)
        }
    }
}
