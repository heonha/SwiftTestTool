//
//  BaseButton.swift
//  SwiftTestTool
//
//  Created by HeonJin Ha on 5/5/24.
//

import SwiftUI

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
