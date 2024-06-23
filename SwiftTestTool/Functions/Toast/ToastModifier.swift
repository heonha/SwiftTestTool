//
//  ToastModifier.swift
//  SwiftTestTool
//
//  Created by Heonjin Ha on 6/23/24.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    
    @Binding var toast: Toast?
    @State private var workItem: DispatchWorkItem?
    @State private var offsetAnchor: CGFloat = 64
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainToastView()
                        .offset(y: offsetAnchor)
                        .animation(.bouncy(), value: offsetAnchor)
                        .onChange(of: toast) { value in
                            showToast()
                        }
                }
            )
    }
    
    @ViewBuilder 
    func mainToastView() -> some View {
        if let toast = toast {
            VStack {
                Spacer()

                ToastView(style: toast.style, message: toast.message, width: toast.width) {
                    dismissToast()
                }
                
            }
        }
    }
    
    private func showToast() {
        
        guard let toast = toast else { return }
        
        self.offsetAnchor = -96

        UIImpactFeedbackGenerator(style: .light)
            .impactOccurred()
        
        if toast.duration > 0 {
            workItem?.cancel()
        }
        let task = DispatchWorkItem {
            dismissToast()
        }
        
        workItem = task
        
        DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
    }
    
    private func dismissToast() {
        withAnimation {
            toast = nil
            offsetAnchor = 64
        }
        
        workItem?.cancel()
        workItem = nil
    }
    
    
}

extension View {
    
    func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
    
}

#Preview {
    ToastTestView()
}
