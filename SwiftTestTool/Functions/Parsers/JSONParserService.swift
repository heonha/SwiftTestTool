//
//  JSONParserService.swift
//  SwiftTestTool
//
//  Created by Heonjin Ha on 5/11/24.
//

import Foundation

class JSONParserService: Service, FileExportable {
    
    public func encode(_ data: Encodable) throws -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(data)
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            throw JSONParserServiceError.encodeError(format: .utf8)
        }
        return jsonString
    }
    
    public func decode<T: Decodable>(_ data: Data, type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(type.self, from: data)
        return decodedData
    }
    
    /// JSON 파일로 export
    public func exportToJSON(_ data: Encodable, fileName: String) throws {
        guard let jsonData = try encode(data).data(using: .utf8) else {
            throw JSONParserServiceError.encodeError(format: .utf8)
        }
        try export(data: jsonData, fileName: fileName, extString: "json")
    }
        
}

// MARK: - Error
enum JSONParserServiceError: Error, LocalizedError {
    case encodeError(format: String.Encoding)
    
    var errorDescription: String? {
        switch self {
        case .encodeError(let format):
            return "Data -> String으로 변환 실패. \(format.description)"
        }
    }
}

