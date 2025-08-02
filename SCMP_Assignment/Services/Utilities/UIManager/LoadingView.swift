//
//  LoadingView.swift
//  SCMP_Assignment
//
//  Created by James on 2/8/2025.
//
import SwiftUI


struct LoadingView: View {
    let message: String
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            VStack(spacing: 10) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
                    .tint(.white)
                Text(message)
                    .foregroundColor(.white)
                    .font(.body)
            }
            .padding(20)
            .background(Color.black.opacity(0.8))
            .cornerRadius(10)
        }
        .zIndex(2)
        .transition(.opacity)
    }
}
