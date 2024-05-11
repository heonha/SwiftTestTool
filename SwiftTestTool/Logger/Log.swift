//
//  Log.swift
//  SwiftTestTool
//
//  Created by Heonjin Ha on 5/11/24.
//

import Foundation

struct Log: Identifiable {
    let id: UUID = .init()
    let category: String
    let timeStamp: Date = .init()
    let message: String
}
