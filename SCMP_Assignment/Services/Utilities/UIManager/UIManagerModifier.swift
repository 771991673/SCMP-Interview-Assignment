//
//  UIManagerModifier.swift
//  SCMP_Assignment
//
//  Created by James on 2/8/2025.
//

import SwiftUI

struct UIManagerModifier: ViewModifier {
    @ObservedObject private var uiManager = UIManager.shared
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if uiManager.isShowing {
                VStack {
                    if uiManager.position == .top {
                        ToastView(message: uiManager.message, position: uiManager.position)
                        Spacer()
                    } else {
                        Spacer()
                        ToastView(message: uiManager.message, position: uiManager.position)
                    }
                }
                .animation(.easeInOut(duration: 0.3), value: uiManager.isShowing)
            }
            
            if uiManager.isShowingLoading {
                LoadingView(message: uiManager.loadingMessage)
                    .animation(.easeInOut(duration: 0.3), value: uiManager.isShowingLoading)
            }
        }
    }
}

extension View {
    func uiManager() -> some View {
        self.modifier(UIManagerModifier())
    }
}
