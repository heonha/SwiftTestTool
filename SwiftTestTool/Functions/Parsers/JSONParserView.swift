//
//  JSONParserView.swift
//  SwiftTestTool
//
//  Created by Heonjin Ha on 5/11/24.
//

import SwiftUI
import UIKit

struct TestUserObject: Codable {
    var id: Int
    var name: String
    var email: String
}

struct JSONParserView: View {
    
    @StateObject private var viewModel = JSONParserViewModel()
    @State private var showingExporter = false
    private let logger = AppLogger(category: "JSONParserView")

    init(viewModel: JSONParserViewModel = .init()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        List {
            Button("Export Multiple JSON") {
                viewModel.exportJSON(data: viewModel.users)
                showingExporter.toggle()
            }
            .fileExporter(isPresented: $showingExporter,
                          document: viewModel.textDocument,
                          contentType: .json) { result in
                switch result {
                case .success(let url):
                    print("Saved to \(url)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            Button("Export JSON") {
                viewModel.exportJSON(data: viewModel.user)
                showingExporter.toggle()
            }
            .fileExporter(isPresented: $showingExporter, 
                          document: viewModel.textDocument,
                          contentType: .json) { result in
                switch result {
                case .success(let url):
                    print("Saved to \(url)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    JSONParserView()
}
