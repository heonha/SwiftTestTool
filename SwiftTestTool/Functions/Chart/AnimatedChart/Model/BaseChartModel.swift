//
//  BaseChartModel.swift
//  everyswim
//
//  Created by HeonJin Ha on 4/27/24.
//

import Foundation

struct BaseChartModel: ChartProtocol {
    var id: UUID = UUID()
    var date: Date
    var value: Double
    var animate: Bool = false
}

struct SwimChartModel: ChartProtocol {
    var id: UUID = UUID()
    var date: Date
    var value: Double
    var animate: Bool = false

    
}


enum SwimDataType {
    case distance
    case duration
    case lapCount
    case count
    case pace
    case kcal
}

extension SwimChartModel {
    
    static var examples: [SwimChartModel] = [
        SwimChartModel(date: Date().addingDate(component: .day, amount: -5),  value: 10),
        SwimChartModel(date: Date().addingDate(component: .day, amount: -4), value: 20),
        SwimChartModel(date: Date().addingDate(component: .day, amount: -3), value: 30),
        SwimChartModel(date: Date().addingDate(component: .day, amount: -2), value: 40),
        SwimChartModel(date: Date().addingDate(component: .day, amount: -1), value: 50),
        SwimChartModel(date: Date().addingDate(component: .day, amount: 0), value: 60)
    ]
    
}
extension BaseChartModel {
    
    static var examples: [BaseChartModel] = [
        BaseChartModel(date: Date().addingDate(component: .day, amount: -5),  value: 10),
        BaseChartModel(date: Date().addingDate(component: .day, amount: -4), value: 20),
        BaseChartModel(date: Date().addingDate(component: .day, amount: -3), value: 30),
        BaseChartModel(date: Date().addingDate(component: .day, amount: -2), value: 40),
        BaseChartModel(date: Date().addingDate(component: .day, amount: -1), value: 50),
        BaseChartModel(date: Date().addingDate(component: .day, amount: 0), value: 60)
    ]
    
}
