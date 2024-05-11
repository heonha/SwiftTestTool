//
//  FileExportable.swift
//  SwiftTestTool
//
//  Created by Heonjin Ha on 5/11/24.
//

import Foundation

protocol FileExportable {
    func export(data: Data, fileName: String, extString: String) throws
}

extension FileExportable {
    func export(data: Data, fileName: String, extString: String) throws {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("\(fileName).\(extString)")
        try data.write(to: fileURL)
    }
}
