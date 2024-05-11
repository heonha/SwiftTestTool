//
//  AnyObject+Ext.swift
//  SwiftTestTool
//
//  Created by Heonjin Ha on 5/11/24.
//

import Foundation

extension NSObject {
    
    static func getObjectName() -> String {
        String(describing: self)
    }
    
}
