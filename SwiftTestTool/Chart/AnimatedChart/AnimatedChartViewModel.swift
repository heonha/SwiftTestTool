
//
//  ChartViewModel.swift
//  everyswim
//
//  Created by HeonJin Ha on 4/27/24.
//

import Foundation

class AnimatedChartViewModel: ObservableObject {
    
    @Published var plotWidth: CGFloat = 0
    @Published var chartPlaceholder: [BaseChartModel] = sample_analytics_placeholder_for_empty

    public func calculateDragMarkX() -> CGFloat {
        let plotWidth = plotWidth
        let count = CGFloat(-chartPlaceholder.count)
        let barWidth = plotWidth / count
        return count * 1.3
    }
    
    // 주석 위치 계산 함수
    public func calculateAnnotationPositionX(currentActiveItem: BaseChartModel?) -> CGFloat {
        // 이 함수는 주석의 X 위치를 계산합니다. 예를 들어, 차트 내 RuleMark의 위치를 계산할 수 있습니다.
        // RuleMark의 중앙 위치 계산
        let barWidth = plotWidth / CGFloat(chartPlaceholder.count)
        let index = chartPlaceholder.reversed().firstIndex(where: { $0.date == currentActiveItem?.date ?? Date(timeIntervalSince1970: 0) }) ?? 0
        return CGFloat(index) * barWidth + barWidth / 2
    }
    
}

// MARK: - Convert Data
extension AnimatedChartViewModel {
    
    // MARK: 데이터를 차트 모델로
    public func convertSwimToChartModel() {
        let now = Date() // 현재 날짜 및 시간
        let pastWeekDate = Calendar.current.date(byAdding: .day, value: -6, to: now)! // 일주일 전 날짜
        
        // 최근 7일간 데이터 필터링
        let recentData = sample_analytics_swim.filter { $0.date >= pastWeekDate }
        
        // 날짜별로 데이터 합산
        var dataByDate = [Date: Int]()
        for data in recentData {
            let startOfDay = Calendar.current.startOfDay(for: data.date) // 날짜 정규화
            dataByDate[startOfDay, default: 0] += Int(data.value)
        }
        
        print("이전 데이터 필터: \(recentData.count) / \(recentData.map(\.date))")
        
        // sample_analytics_placeholder 업데이트
        for index in 0..<chartPlaceholder.count {
            let placeholderDate = Calendar.current.startOfDay(for: chartPlaceholder[index].date)
            if let newValue = dataByDate[placeholderDate] {
                chartPlaceholder[index].value = Double(newValue)
            } else {
                chartPlaceholder[index].value = 0 // 일치하는 날짜가 없는 경우 값은 0으로 설정
            }
        }
    }
    
    func convertSwimToChartModel(from swimArray: [any ChartProtocol], component: Calendar.Component) {
        
        guard !swimArray.isEmpty else {
            print("Swim Array가 비어있습니다.")
            return
        }
        
        let now = Date() // 현재 날짜 및 시간
        let pastWeekDate = Calendar.current.date(byAdding: component, value: -6, to: now)! // 일주일 전 날짜
        // 최근 7일간 데이터 필터링
        let recentData = swimArray.filter { $0.date >= pastWeekDate }
        
        // 날짜별로 데이터 합산
        var dataByDate = [Date: Double]()
        for data in recentData {
            let startOfDay = Calendar.current.startOfDay(for: data.date) // 날짜 정규화
            dataByDate[startOfDay, default: 0] += data.value
        }
        
        print("이전 데이터 필터: \(recentData.count) / \(recentData.map(\.date))")
        
        // sample_analytics_placeholder 업데이트
        for index in 0..<chartPlaceholder.count {
            let placeholderDate = Calendar.current.startOfDay(for: chartPlaceholder[index].date)
            if let newValue = dataByDate[placeholderDate] {
                chartPlaceholder[index].value = newValue
            } else {
                chartPlaceholder[index].value = 0 // 일치하는 날짜가 없는 경우 값은 0으로 설정
            }
        }
    }
    
}
