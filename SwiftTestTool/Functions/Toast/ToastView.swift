//
//  ToastView.swift
//  SwiftTestTool
//
//  Created by Heonjin Ha on 6/18/24.
//

import SwiftUI

struct ToastView: View {
    
    var style: Toast.ToastStyle
    var message: String
    var width = CGFloat.infinity
    var onCancelTapped: (() -> Void)
    
    var body: some View {
        
        HStack {
            Spacer()

            HStack(alignment: .center, spacing: 12) {
                if !style.systemName.isEmpty {
                    Image(systemName: style.systemName)
                        .foregroundStyle(style.themeColor)
                }
                
                Text(message)
                    .font(.caption)
                    .foregroundStyle(Color.init(uiColor: .label))

            }
            .padding()
            .background(Material.ultraThin)
            .cornerRadius(8)
            .shadow(radius: 1)
            .gesture(
                DragGesture(coordinateSpace: .global)
                    .onEnded { value in
                        if value.translation.height > 50 {
                            onCancelTapped()
                        }
                    }
            )
            .frame(maxWidth: .infinity)
            
            Spacer()
        }
        
        
    }
}

#Preview {
    VStack(spacing: 32) {
        ToastView(style: .success, message: "success") {
            print("Cancel Tapped")
        }
        
        ToastView(style: .info, message: "Info") {
            print("Info Tapped")
        }
        
        ToastView(style: .warning, message: "Warning Warning Warning Warning Warning Warning") {
            print("Cancel Tapped")
        }
        
        ToastView(style: .error, message: "Error") {
            print("Cancel Tapped")
        }
    }

}
