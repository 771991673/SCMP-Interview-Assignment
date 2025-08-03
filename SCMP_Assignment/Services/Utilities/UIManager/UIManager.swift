//
//  UIManager.swift
//  SCMP_Assignment
//
//  Created by James on 2/8/2025.
//

import SwiftUI

class UIManager: ObservableObject {
    
    static let shared = UIManager()
    
    
    @Published private(set) var isShowing: Bool = false
    @Published private(set) var message: String = ""
    @Published private(set) var duration: Double = 2.0
    @Published private(set) var position: ToastPosition = .bottom
    
    @Published private(set) var isShowingLoading: Bool = false
    @Published private(set) var loadingMessage: String = "Loading..."
    
    enum ToastPosition {
        case top, bottom
    }
    
    private init() {}
    
    func showToast(message: String, duration: Double = 2.0, position: ToastPosition = .bottom) {
        DispatchQueue.main.async {
            self.message = message
            self.duration = duration
            self.position = position
            self.isShowing = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.hideToast()
            }
        }
    }
    
    func hideToast() {
        DispatchQueue.main.async {
            self.isShowing = false
        }
    }
    
    
    func showLoading(message: String = "Loading...") {
        DispatchQueue.main.async {
            self.loadingMessage = message
            self.isShowingLoading = true
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.isShowingLoading = false
        }
    }
}

