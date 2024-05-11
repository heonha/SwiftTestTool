//
//  ChartSamples.swift
//  everyswim
//
//  Created by HeonJin Ha on 4/27/24.
//

import Foundation

#if DEBUG
var sample_analytics_placeholder_for_empty: [BaseChartModel] = []
var sample_analytics_placeholder_for_day: [BaseChartModel] = sample_week_chart(from: 0, to: -7, by: -1)
var sample_analytics_placeholder_for_Week: [BaseChartModel] = sample_week_chart(from: 0, to: -42, by: -7)

func sample_week_chart(from start: Double, to end: Double, by gap: Double) -> [BaseChartModel] {
    var arr = [BaseChartModel]()
    for number in stride(from: start, to: end, by: gap) {
        arr.append(BaseChartModel(date: Date().updateDay(value: number), value: 0))
    }
    return arr
}

struct SwimSampleData: ChartProtocol {
    var id: UUID = .init()
    var date: Date
    var value: Double
    var animate: Bool = false
}

var sample_analytics_swim: [SwimSampleData] = [
    .init(date: Date().updateDay(value: -34), value: 30),
    .init(date: Date().updateDay(value: -27), value: 40),
    .init(date: Date().updateDay(value: -21), value: 50),
    .init(date: Date().updateDay(value: -14), value: 60),

    .init(date: Date().updateDay(value: -10), value: 10),
    .init(date: Date().updateDay(value: -9), value: 20),
    .init(date: Date().updateDay(value: -8), value: 30),
    .init(date: Date().updateDay(value: -7), value: 40),
    .init(date: Date().updateDay(value: -6), value: 50),
    .init(date: Date().updateDay(value: -4), value: 60),
    .init(date: Date().updateDay(value: -3), value: 70),
    .init(date: Date().updateDay(value: -1), value: 80)
]
#endif

extension Date {
    /// 날짜 변경 (-는 이전 +는 이후)
    func updateDay(value: Double) -> Date {
        let add = 86400.0 * value
        return self.addingTimeInterval(add)
    }
    
    func addingDate(component: Calendar.Component, amount: Int) -> Date {
        let calendar = Calendar.current
        let calculatedComponent = offsetComponent(currentDate: self, component: component, amount: amount)
        print("CAL-DEBUG: \(calculatedComponent)")
        let dateFromComponents = calendar.date(from: calculatedComponent)
        return dateFromComponents!
    }
    
    private func offsetComponent(currentDate: Date, component: Calendar.Component, amount: Int) -> DateComponents {
        let calendar = Calendar.current
        var offsetComponents = DateComponents()
        let componentSet: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second, .weekOfMonth, .weekOfYear, .yearForWeekOfYear, .timeZone, .calendar]
        
        switch component {
        case .year:
            offsetComponents.year = amount
        case .month:
            offsetComponents.month = amount
        case .day:
            offsetComponents.day = amount
        case .hour:
            offsetComponents.hour = amount
        case .minute:
            offsetComponents.minute = amount
        case .second:
            offsetComponents.second = amount
        case .weekOfYear:
            offsetComponents.weekOfYear = amount
        case .weekOfMonth:
            offsetComponents.weekOfMonth = amount
        default:
            return DateComponents()
        }
        
        let oneYearBefore = calendar.date(byAdding: offsetComponents, to: currentDate)
        return calendar.dateComponents(componentSet, from: oneYearBefore!)
    }
}
