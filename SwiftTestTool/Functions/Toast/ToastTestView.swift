//
//  ToastTestView.swift
//  SwiftTestTool
//
//  Created by Heonjin Ha on 6/23/24.
//

import SwiftUI

struct ToastTestView: View {
    
    @State private var toast: Toast? = nil
    
    var body: some View {
        VStack(spacing: 32) {
            Button {
                toast = Toast(style: .success, message: "Success", width: 160)
            } label: {
                Text("Success Text")
            }
            
            Button {
                toast = Toast(style: .info, message: "info")
            } label: {
                Text("info Text")
            }

            Button {
                toast = Toast(style: .warning, message: "warning", width: 160)
            } label: {
                Text("warning Text")
            }

            Button {
                toast = Toast(style: .error, message: "error", width: 160)
            } label: {
                Text("error Text")
            }

        }
        .toastView(toast: $toast)
    }
}

#Preview {
    ToastTestView()
}
