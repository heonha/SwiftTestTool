//
//  HapticManager.swift
//  SwiftTestTool
//
//  Created by HeonJin Ha on 5/4/24.
//

import SwiftUI
import CoreHaptics

final class HapticManager {
    
    private init() {}

    static func triggerHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }

        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
    
}
