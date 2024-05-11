//
//  ChartType.swift
//  everyswim
//
//  Created by HeonJin Ha on 4/27/24.
//

import Foundation

enum ChartType: String, Hashable, CaseIterable, Identifiable {
    var id: Self { self }
    case bar = "Bar"
    case line = "Line"
}
