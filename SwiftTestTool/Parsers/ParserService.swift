//
//  ParserService.swift
//  SwiftTestTool
//
//  Created by Heonjin Ha on 5/11/24.
//

import Foundation

class ParserService: NSObject {
    
    func parse() {
        
    }
    
}

class JSONParserService: ParserService {
    
    private var encoder = JSONEncoder()
    
    override func parse() {
        super.parse()
        
    }
    
    private func encode(_ data: Encodable) {
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let jsonData = try encoder.encode(data)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("\(jsonString)")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func decode() {
        
    }
    
}
