//
//  Toast.swift
//  SwiftTestTool
//
//  Created by Heonjin Ha on 6/18/24.
//

import SwiftUI

struct Toast: Equatable {
    
    var style: ToastStyle
    var message: String
    var duration: Double = 3
    var width: Double = .infinity
    var withAnimation: Bool = false
    
    enum ToastStyle {
       case error, warning, success, info

        var themeColor: Color {
            switch self {
            case .error: .red
            case .warning: .orange
            case .success: .green
            case .info: .blue
            }
        }
        
        var systemName: String {
          switch self {
          case .info: return ""
          case .warning: return "exclamationmark.triangle.fill"
          case .success: return "checkmark.circle.fill"
          case .error: return "xmark.circle.fill"
          }
        }
    }
    
}


