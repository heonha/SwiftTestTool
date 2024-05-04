//
//  ContentView.swift
//  SwiftTestTool
//
//  Created by HeonJin Ha on 5/4/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                BaseButton(title: "rigid") {
                    HapticManager.triggerHapticFeedback(style: .rigid)
                }
                
                BaseButton(title: "soft") {
                    HapticManager.triggerHapticFeedback(style: .soft)
                }
                
                BaseButton(title: "light") {
                    HapticManager.triggerHapticFeedback(style: .light)
                }
                
                BaseButton(title: "medium") {
                    HapticManager.triggerHapticFeedback(style: .medium)
                }
                
                BaseButton(title: "heavy") {
                    HapticManager.triggerHapticFeedback(style: .heavy)
                }
            }
        }
        .frame(height: 48)
        .padding()
    }
    
}

#Preview {
    ContentView()
}

struct BaseButton: View {
    
    var title: String
    var cornerRadius: CGFloat
    @State var action: () -> Void
    
    init(title: String, cornerRadius: CGFloat = 8, action: @escaping () -> Void) {
        self.title = title
        self.cornerRadius = cornerRadius
        self._action = State(initialValue: action)
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Material.regular)
                
                Text(title)
                    .foregroundStyle(Color.init(uiColor: .label))
            }
        }
    }
}
