//
//  ChartSegment.swift
//  everyswim
//
//  Created by HeonJin Ha on 4/27/24.
//

import Foundation

// MARK: - ChartSegment
enum ChartSegment: String, CaseIterable, Identifiable {
    case notSelected
    case daily // 일주일 보여주기
    case weekly // 달의 주간 보여주기
    case monthly // 연의 달별로 보여주기
    case yearly // 전체 연별로 보여주기
    
    var id: String {
        self.rawValue
    }
    
    var title: String {
        switch self {
        case .notSelected:
            return "--"
        case .daily:
            return "이번 주"
        case .weekly:
            return "주차 별"
        case .monthly:
            return "월 별"
        case .yearly:
            return "연간"
        }
    }
    
    var targetComponent: Calendar.Component {
        switch self {
        case .notSelected:
            return .day
        case .daily:
            return .day
        case .weekly:
            return .weekOfYear
        case .monthly:
            return .month
        case .yearly:
            return .year
        }
    }
    
    var domainXAxis: Int {
        switch self {
        case .notSelected:
            return 0
        case .daily:
            return 7
        case .weekly:
            return 6
        case .monthly:
            return 6
        case .yearly:
            return 5
        }
    }
    
    var xformatStyle: Date.FormatStyle {
        switch self {
        case .notSelected:
            return  .dateTime.day()
        case .daily:
            return  .dateTime.day()
        case .weekly:
            return  .dateTime.week()
        case .monthly:
            return  .dateTime.month()
        case .yearly:
            return  .dateTime.year()
        }
    }
    
    var placeholders: [BaseChartModel] {
        switch self {
        case .daily:
            return sample_analytics_placeholder_for_day
        case .weekly:
            return sample_analytics_placeholder_for_Week
        default:
            return sample_analytics_placeholder_for_empty
        }
    }
    
    var unit: String {
        switch self {
        case .notSelected:
            return ""
        case .daily:
            return "일"
        case .weekly:
            return "주"
        case .monthly:
            return "월"
        case .yearly:
            return "년"
        }
    }

}
