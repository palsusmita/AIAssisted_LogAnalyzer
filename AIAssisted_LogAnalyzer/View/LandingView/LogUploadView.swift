//
//  LogUploadView.swift
//  AIAssisted_LogAnalyzer
//
//  Created by susmita on 28/01/26.
//

import SwiftUI

struct LogUploadView: View {

    @StateObject private var viewModel =
    AppDIContainer.makeLogAnalysisViewModel()
    @FocusState private var isEditorFocused: Bool
    @State private var navigateToMetrics = false

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(spacing: 28) {

                    // MARK: Header Section
                    VStack(alignment: .leading, spacing: 8) {

                        Text("Operational Intelligence")
                            .font(.title2.weight(.semibold))

                        Text("Upload or paste business logs to generate financial insights and predictive analytics.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                    // MARK: Input Section
                    VStack(alignment: .leading, spacing: 12) {

                        Text("Log Input")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.secondary)

                        TextEditor(text: $viewModel.logText)
                            .focused($isEditorFocused)
                            .frame(minHeight: 200)
                            .padding(12)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.gray.opacity(0.25), lineWidth: 1)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color(.systemBackground))
                                    )
                            )
                    }
                    .padding(.horizontal)

                    // MARK: Analyze Button
                    Button {
                        Task {
                            await viewModel.analyze()
                            if !viewModel.metrics.isEmpty {
                                navigateToMetrics = true
                            }
                        }
                    } label: {

                        HStack {
                            if viewModel.isLoading {
                                ProgressView()
                                    .tint(.white)
                            } else {
                                Image(systemName: "chart.bar.doc.horizontal")
                            }

                            Text(viewModel.isLoading ? "Analyzing…" : "Generate Insights")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.lightOrange)
                        .foregroundStyle(.darkBrown)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .padding(.horizontal)
                    .disabled(viewModel.isLoading || viewModel.logText.isEmpty)

                    Spacer(minLength: 40)
                }
                .padding(.top, 30)
            }
            .background(Color(.systemGroupedBackground))
            .navigationDestination(isPresented: $navigateToMetrics) {
                MetricsResultView(metrics: viewModel.metrics)
            }
        }
    }
}


