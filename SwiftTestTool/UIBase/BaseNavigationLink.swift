//
//  BaseNavigationLink.swift
//  SwiftTestTool
//
//  Created by HeonJin Ha on 5/5/24.
//

import SwiftUI

struct BaseNaviLink<Destination> : View where Destination : View {
    
    @ViewBuilder
    var destination: () -> Destination
    var title: String
    
    init(_ title: String, @ViewBuilder destination: @escaping () -> Destination) {
        self.title = title
        self.destination = destination
    }
    
    var body: some View {
        NavigationLink {
            destination()
                .navigationTitle(title)
        } label: {
            Text(title)
        }

    }
}
