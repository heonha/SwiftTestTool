//
//  JSONParserViewModel.swift
//  SwiftTestTool
//
//  Created by Heonjin Ha on 5/11/24.
//

import Foundation

final class JSONParserViewModel: ViewModel {
    
    @Published var resultText = "-"
    private var parser = JSONParserService()
    let user = TestUserObject(id: 0, name: "123", email: "123@1231231.com")
    let users = [
        TestUserObject(id: 0, name: "123", email: "abab@1231231.com"),
        TestUserObject(id: 1, name: "456", email: "cvcv@1231231.com"),
        TestUserObject(id: 2, name: "12313", email: "sds@1231231.com"),
        TestUserObject(id: 3, name: "1222", email: "qew@1231231.com")
    ]
    var textDocument: TextDocument = .init(text: "")
    
    func getDefaultFileName() -> String {
        let currentTimeString = String(format: "%.f", Date().timeIntervalSince1970 * 10)
        return "ExportJSON-\(currentTimeString)"
    }
    
    func exportJSON<T: Encodable>(data: T) {
        do {
            let jsonText = try parser.encode(data)
            self.textDocument = TextDocument(text: jsonText)
        } catch {
            logger.error(error.localizedDescription)
        }
    }
    
    func exportJSON<T: Encodable>(data: [T]) {
        do {
            let jsonText = try parser.encode(data)
            self.textDocument = TextDocument(text: jsonText)
        } catch {
            logger.error(error.localizedDescription)
        }
    }
    
}
