//
//  MetricsResultView.swift
//  AIAssisted_LogAnalyzer
//
//  Created by susmita on 19/02/26.
//

import SwiftUI

struct MetricsResultView: View {

    let metrics: [Metric]

    var body: some View {

        ScrollView {

            VStack(spacing: 20) {

                HStack(spacing: 12) {
                    Image(systemName: "chart.bar.xaxis")
                        .font(.system(size: 24))
                        .foregroundStyle(.blue)

                    VStack(alignment: .leading) {
                        Text("Analysis Results")
                            .font(.title2.bold())

                        Text("Key operational metrics extracted from logs")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    Spacer()
                }
                .padding(.horizontal)
                MetricsChartView(metrics: metrics)
            }
            .padding(.top)
        }
        .navigationTitle("Metrics")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.lightOrange)
    }
}
