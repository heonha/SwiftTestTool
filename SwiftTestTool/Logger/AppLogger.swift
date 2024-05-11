//
//  AppLogger.swift
//  SwiftTestTool
//
//  Created by Heonjin Ha on 5/11/24.
//

import Foundation
import os.log
import SwiftUI

struct AppLogger {
    
    private let logger: Logger
    private let logStore = LogStore.shared
    private let category: String
    
    init(category: String) {
        self.category = category
        self.logger = Logger(subsystem: Constants.APP_BUNDLE_ID, category: category)
    }
        
}

extension AppLogger {
    
    public func info(_ message: String) {
        logger.info("\(message)")
        logStore.appendLog(.init(category: category, message: message))
    }
    
    public func debug(_ message: String) {
        logger.debug("\(message)")
        logStore.appendLog(.init(category: category, message: message))
    }
    
    public func warning(_ message: String) {
        logger.warning("\(message)")
        logStore.appendLog(.init(category: category, message: message))
    }
    
    public func error(_ message: String) {
        logger.error("\(message)")
        logStore.appendLog(.init(category: category, message: message))
    }
    
    public func notice(_ message: String) {
        logger.notice("\(message)")
        logStore.appendLog(.init(category: category, message: message))
    }
    
    public func critical(_ message: String) {
        logger.critical("\(message)")
        logStore.appendLog(.init(category: category, message: message))
    }
    
    public func log(_ message: String) {
        logger.log("\(message)")
        logStore.appendLog(.init(category: category, message: message))
    }
    
    public func log(level: OSLogType, _ message: String) {
        logger.log(level: level, "\(message)")
        logStore.appendLog(.init(category: category, message: message))
    }

}
