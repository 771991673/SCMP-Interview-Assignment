//
//  LoginView.swift
//  SCMP_Assignment
//
//  Created by James on 2/8/2025.
//
import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var router: Router

    @StateObject private var viewModel: LoginViewModel
    
    init(router: Router) {
        _viewModel = StateObject(wrappedValue: LoginViewModel(router: router))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding(.horizontal)
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Button(action: {
                Task {
                    let success = await viewModel.login()
                
                }
            }) {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
        .padding()
        .onAppear {
            
        }
    }
}
