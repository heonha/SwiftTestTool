//
//  ContentView.swift
//  SwiftTestTool
//
//  Created by HeonJin Ha on 5/4/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationStack {
            List {
                
                Section("UX") {
                    BaseNaviLink("Haptic") {
                        HapticView()
                    }
                }
                
                Section("Chart") {
                    BaseNaviLink("BarChart") {
                        PracticeChartView()
                    }
                }

                
            }
        }
        .navigationTitle("Tools")
    }
    
}

#Preview {
    ContentView()
}
