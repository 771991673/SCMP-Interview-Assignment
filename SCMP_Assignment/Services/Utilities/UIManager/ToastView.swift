//
//  ToastView.swift
//  SCMP_Assignment
//
//  Created by James on 2/8/2025.
//

import SwiftUI

struct ToastView: View {
    let message: String
    let position: UIManager.ToastPosition
    
    var body: some View {
        Text(message)
            .padding()
            .background(Color.black.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.vertical, position == .top ? 50 : 20)
            .padding(.horizontal)
            .transition(.opacity.combined(with: .move(edge: position == .top ? .top : .bottom)))
            .zIndex(1)
            .accessibilityIdentifier("toastText")
        
    }
}
