//
//  File.swift
//  SwiftTestTool
//
//  Created by Heonjin Ha on 5/11/24.
//

import UniformTypeIdentifiers
import SwiftUI

struct TextDocument: FileDocument {
    static var readableContentTypes: [UTType] {
        [.plainText, .json]
    }
    
    var text = ""
    
    init(text: String) {
        self.text = text
    }
    
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            text = String(decoding: data, as: UTF8.self)
        } else {
            text = ""
        }
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper(regularFileWithContents: Data(text.utf8))
    }
}
