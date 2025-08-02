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
        autoLogin()
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
            let filtered = password.filter { $0.isLetter || $0.isNumber }
            if filtered.count >= 6 && filtered.count <= 10 {
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
//                TODO: login api call
                
                
                errorMessage = nil
                success = true
            } else {
                errorMessage = "Invalid credentials"
                success = false
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
