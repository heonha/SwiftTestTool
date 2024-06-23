//
//  ChartView.swift
//  everyswim
//
//  Created by HeonJin Ha on 4/27/24.
//

import SwiftUI
import Charts

// MARK: - View
struct ChartView: View {
    
    // Binding
    @Binding private var currentTab: ChartSegment
    @Binding private var swimData: [any ChartProtocol]
    private var requestType: SwimDataType
    
    // View Property
    @State private var valueTitle: String = "-"
    @State private var targetComponent: Calendar.Component = .day
    @State private var isLineGraph: Bool = false
    
    // Gesture Properties
    @State private var center: CGFloat = 0
    @State private var currentActiveItem: BaseChartModel?

    @StateObject private var viewModel = AnimatedChartViewModel()
    
    // MARK: Init
    init(currentTab: Binding<ChartSegment>,
         swimData: Binding<[any ChartProtocol]>,
         requestType: SwimDataType,
         viewModel: AnimatedChartViewModel = AnimatedChartViewModel()) {
        self._currentTab = currentTab
        self._swimData = swimData
        self.requestType = requestType
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            mainBody
        }
    }
    
    private var mainBody: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack {
                let totalValue = viewModel.chartPlaceholder.reduce(0.0) { partResult, item in
                    item.value + partResult
                }
                
                Text("\(totalValue)")
                    .bold()
                
                animatedChart()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onChange(of: currentTab) { newValue in // 분할된 탭의 값을 간단히 업데이트하기
            // 데이터 변환하기
            self.targetComponent = newValue.targetComponent // 컴포넌트 전환
            viewModel.chartPlaceholder = newValue.placeholders // 자리도 수정
            // 탭이 변했다!
            #if targetEnvironment(simulator)
            viewModel.convertSwimToChartModel()
            #else
            viewModel.convertSwimToChartModel(from: swimData, component: newValue.targetComponent)
            #endif
            // 여기서부턴 뷰 조절
            animateGraph(fromChange: true)  // RE-Animating View
        }
    }
    
}

// MARK: SubViews
extension ChartView {
    // MARK: Chart
    @ViewBuilder
    private func animatedChart() -> some View {
        let max = viewModel.chartPlaceholder.max { $0.value < $1.value }?.value ?? 0
        // let max = 1000.0

        Chart {
            ForEach(viewModel.chartPlaceholder) { item in
                // MARK: Graphsanimate
                if isLineGraph {
                    LineMark(
                        x: .value("Hour", item.date, unit: targetComponent),
                        y: .value("Views", item.animate ? item.value : 0)
                    )
                    .foregroundStyle(.blue.gradient)
                    .interpolationMethod(.catmullRom)
                    
                    AreaMark(
                        x: .value("Hour", item.date, unit: targetComponent),
                        y: .value("Views", item.animate ? item.value : 0)
                    )
                    .foregroundStyle(.blue.opacity(0.1).gradient)
                    .interpolationMethod(.catmullRom)
                    
                } else {
                    BarMark(
                        x: .value("Hour", item.date, unit: targetComponent),
                        y: .value("Views", item.animate ? item.value : 0)
                    )
                    .foregroundStyle(.blue.gradient)
                }
                
                // MARK: Drag Mark
                // Rule Mark For Currently Dragging Item
                if let currentActiveItem = currentActiveItem, currentActiveItem.id == item.id {
                    chartDragMark(from: currentActiveItem) // 이건 Line임!
                }
            }
        }
        .chartYScale(domain: 0...(max + max * 0.1))
        .chartXAxis { // x축
            AxisMarks(values: .stride(by: currentTab.targetComponent, count: 1)) { _ in // AxisValue in
                AxisValueLabel(format: currentTab.xformatStyle, centered: true)
            }
        }
        .chartOverlay { chartOverlay($0) } // Gesture To Highlight Current Bar
        .overlay(chartLabel(), alignment: .topLeading)
        .frame(height: 250)
        .onAppear {
            animateGraph()
        }
    }
    
    func convertDateToString(currentTab: ChartSegment, date: Date) -> String {
        let calendar = Calendar.current
        let componentString = calendar.component(currentTab.targetComponent, from: date).description + currentTab.unit
        switch currentTab {
        case .notSelected:
            return ""
        case .daily:
            let monthString = calendar.component(.month, from: date).description + "월"
            return monthString + " " + componentString
        case .weekly:
            return componentString
        case .monthly:
            return componentString
        case .yearly:
            return componentString
        }
    }
    
    @ViewBuilder
    private func chartLabel() -> some View {
        
        if let date = currentActiveItem?.date {
            let dateString = convertDateToString(currentTab: currentTab, date: date)
            
            if let valueString = currentActiveItem?.value {
                // 주석을 오버레이로 설정
                VStack(alignment: .center, spacing: 6) {
                    Text("\(dateString)")
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)
                    
                    Text("\(valueString)")
                        .font(.system(size: 14, weight: .bold))
                }
                .padding()
                .frame(height: 40)
                .background(
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(Material.thinMaterial)
                )
                .position(x: viewModel.calculateAnnotationPositionX(currentActiveItem: currentActiveItem), y: -30)
            }
        }

    }
    
    // MARK: Chart Overlay (Gesture)
    @ViewBuilder
    private func chartOverlay(_ proxy: ChartProxy) -> some View {
        GeometryReader { _ in
            Rectangle()
                .fill(.clear)
                .contentShape(Rectangle())
            
            // MARK: - Dragging Gesture
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            // Getting Current Location
                            let location = value.location
                            /// Extracting Value From The Location
                            /// SwiftChants는 이를 수행할 수 있는 직접적인 기능을 제공합니다.
                            /// A축에서 날짜를 추출하겠습니다. 그런 다음 해당 날짜 값을 사용하여 현재 항목을 추출합니다.
                            /// Don't Forgot to Include the perfect Data Type
                            if let date: Date = proxy.value(atX: location.x) {
                                let calendar = Calendar.current
                                let selectedDate = calendar.component(targetComponent, from: date)
                                
                                if let currentItem = viewModel.chartPlaceholder.first(where: { item in
                                    calendar.component(targetComponent, from: item.date) == selectedDate
                                }) {
                                    print("DEBUG-OVERLAY: \(currentItem)")
                                    currentActiveItem = currentItem
                                    viewModel.plotWidth = proxy.plotAreaSize.width
                                }
                            }
                        }
                        .onEnded { _ in currentActiveItem = nil}
                )
        }
    }
    
    private func animateGraph(fromChange: Bool = false) {
        for index in viewModel.chartPlaceholder.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * (fromChange ? 0.03 : 0.05)) {
                withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.8)) {
                    viewModel.chartPlaceholder[index].animate = true
                }
            }
        }
    }
    
    // MARK: 드래그 마크
    private func chartDragMark(from currentActiveItem: BaseChartModel) -> some ChartContent {
        RuleMark(x: .value("X Axis(Date)", currentActiveItem.date)) // Drag Line MARK
            // Dotted Style
            .lineStyle(.init(lineWidth: 2, miterLimit: 2, dash: [2], dashPhase: 5))
            .offset(x: viewModel.calculateDragMarkX()) // 각 막대의 Middle 설정
    }
    
}


extension Double {
    
    func toInt() -> Int {
        return Int(self)
    }
    
    /// 소수점을 제외하고 문자열로 변환합니다.
    func toRoundupString(maxDigit: Int = 0, numberStyle: NumberFormatter.Style = .decimal) -> String {
        let numberToRound: Double = self
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = maxDigit
        formatter.maximumFractionDigits = maxDigit
        formatter.numberStyle = numberStyle
        
        if let roundedString = formatter.string(from: NSNumber(value: numberToRound)) {
            return roundedString
        }
        
        return "-"
    }
    
    func formattedString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
    
    /// For Chart Label
    var stringFormat: String {
        if self >= 10000 && self < 999999 {
            return String(format: "%.1fK", self / 1000).replacingOccurrences(of: ".0", with: "")
        }
        
        if self >= 999999 {
            return String(format: "%.1fM", self / 1_000_000).replacingOccurrences(of: ".0", with: "")
        }
        
        return String(format: "%.1fM", self).replacingOccurrences(of: ".0", with: "")
    }

}
