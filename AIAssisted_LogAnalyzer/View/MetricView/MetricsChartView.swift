//
//  ChartsView.swift
//  AIAssisted_LogAnalyzer
//
//  Created by susmita on 28/01/26.
//

import SwiftUI
import Charts

struct MetricsChartView: View {

    let metrics: [Metric]

    private var maxValue: Double {
        metrics.map(\.value).max() ?? 1
    }

    var body: some View {

        VStack(spacing: 24) {

            // MARK: Header
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Financial Dashboard")
                        .font(.title3.weight(.semibold))

                    Text("Monthly business performance")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
            .padding(.horizontal)

            // MARK: Chart Card
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.06), radius: 10, y: 6)
                .overlay {
                    Chart(financialMetrics) { metric in

                        BarMark(
                            x: .value("Metric", metric.name),
                            y: .value("Value", metric.value)
                        )
                        .foregroundStyle(color(for: metric))
                        .cornerRadius(6)
                        .annotation(position: .top) {
                            Text(formattedValue(metric.value))
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(.primary)
                        }
                    }
                    .chartYAxis {
                        AxisMarks(position: .leading)
                    }
                    .chartXAxis {
                        AxisMarks { value in
                            AxisValueLabel()
                                .font(.caption)
                               // .rotationEffect(.degrees(-35))
                        }
                    }
                    .padding()
                }
                .frame(height: 340)
                .padding(.horizontal)

            // MARK: Metric Cards
            VStack(spacing: 14) {
                ForEach(metrics) { metric in
                    MetricRowView(metric: metric)
                }
            }
            .padding(.horizontal)
        }
        .background(.lightOrange)
    }

    private func color(for metric: Metric) -> Color {

        let lower = metric.name.lowercased()

        if lower.contains("profit") {
            return FinancialColors.profit
        } else if lower.contains("loss") || lower.contains("failure") {
            return FinancialColors.loss
        } else if lower.contains("revenue") {
            return FinancialColors.revenue
        } else {
            return FinancialColors.neutral
        }
    }

    private func formattedValue(_ value: Double) -> String {
        if value >= 1000 {
            return String(format: "%.0f", value)
        } else {
            return String(format: "%.2f", value)
        }
    }
    private var financialMetrics: [Metric] {
        metrics.filter {
            let lower = $0.name.lowercased()
            return lower.contains("revenue") ||
                   lower.contains("cost") ||
                   lower.contains("profit")
        }
    }
}
