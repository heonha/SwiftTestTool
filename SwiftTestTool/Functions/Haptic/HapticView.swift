//
//  HapticView.swift
//  SwiftTestTool
//
//  Created by HeonJin Ha on 5/5/24.
//

import SwiftUI

struct HapticView: View {
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
    HapticView()
}
