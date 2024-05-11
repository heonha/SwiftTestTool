//
//  ChartProtocol.swift
//  everyswim
//
//  Created by HeonJin Ha on 4/27/24.
//

import Foundation

protocol ChartProtocol: Identifiable, Hashable, Equatable {
    var id: UUID { get }
    var date: Date { get set }
    var value: Double { get set }
    var animate: Bool { get set }
}
