//
//  ChartView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 19/08/23.
//

import SwiftUI
import Charts

struct ChartData: Identifiable {
    var id = UUID()
    var xValue: String = ""
    var yValue: Int = 0
}

struct ChartView: View {
    var data: [ChartData] = []
    var body: some View {
        Chart {
            ForEach(data) { item in
                BarMark(
                    x: .value("X Data", item.xValue),
                    y: .value("Y Data", item.yValue)
                )
                .cornerRadius(6, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [Color.yellow, .orange], startPoint: .bottom, endPoint: .top))
                .annotation(position: .top, alignment: .top) {
                    Text(item.yValue.formatted())
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(.quaternary.opacity(0.5), in: Capsule())
                        .background(in: Capsule())
                        .font(.caption)
                }
            }
        }
        .chartYAxis {
            AxisMarks { _ in
                AxisGridLine()
                AxisTick()
                AxisValueLabel(format: IntegerFormatStyle<Int>())
            }
        }
        .chartXAxis {
            AxisMarks { value in
                let xValueLabel = getValueFromAxisValue(for: value)
                AxisValueLabel {
                    VStack {
                        Text("\(xValueLabel.xValue)")
                            .lineLimit(2, reservesSpace: true)
                            .multilineTextAlignment(.center)
                    }
                    .frame(idealWidth: 80)
                    .padding(.horizontal, 4)
                }
            }
        }
        .frame(height: 300)
    }
    func getValueFromAxisValue(for value: AxisValue) -> ChartData {
        guard let xValue = value.as(String.self) else {
            fatalError("Could not convert axis value to expected String type")
        }
        guard let result = data.first(where: { $0.xValue == xValue }) else {
            fatalError("No top performing DonutSales with given donut name: \(xValue)")
        }
        return result
    }
}
