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
                
                Section("Alert") {
                    BaseNaviLink("Toast") {
                        ToastTestView()
                    }
                }
                
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
                
                Section("Data") {
                    BaseNaviLink("JSON Parser") {
                        JSONParserView()
                    }
                }
            }
            .navigationTitle("Swift Test Tools")
        }
    }
    
}

#Preview {
    ContentView()
}
