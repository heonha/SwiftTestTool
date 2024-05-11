//
//  Object.swift
//  SwiftTestTool
//
//  Created by Heonjin Ha on 5/11/24.
//

import Foundation

class Object: NSObject {
    
    static func getObjectName() -> String {
        String(describing: self)
    }
    
    var logger: AppLogger { AppLogger(category: Self.getObjectName()) }

}
