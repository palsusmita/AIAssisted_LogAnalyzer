//
//  MetricRowView.swift
//  AIAssisted_LogAnalyzer
//
//  Created by susmita on 03/03/26.
//

import SwiftUI

struct MetricRowView: View {

    let metric: Metric

    var body: some View {
        HStack {

            VStack(alignment: .leading, spacing: 4) {
                Text(metric.name)
                    .font(.subheadline.weight(.semibold))

                Text(metric.explanation)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }

            Spacer()

            Text(formattedValue(metric.value))
                .font(.headline)
                .foregroundStyle(color(for: metric))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.04), radius: 6, y: 3)
        )
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
}
