//
//  LogStore.swift
//  SwiftTestTool
//
//  Created by Heonjin Ha on 5/11/24.
//

import Foundation

final class LogStore: ObservableObject {
    
    static let shared = LogStore()
    
    private init() {}
    
    /// SwiftUI에서 직접 참조하여 사용합니다. (로그가 동시에 다수 발생 시 이벤트 관리 필요)
    @Published private(set) var logs: [Log] = []
    
    /// Log를 적재합니다.
    public func appendLog(_ log: Log) {
        self.logs.append(log)
    }

}
