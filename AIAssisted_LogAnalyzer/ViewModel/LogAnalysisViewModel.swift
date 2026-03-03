//
//  LogAnalysisViewModel.swift
//  AIAssisted_LogAnalyzer
//
//  Created by susmita on 28/01/26.
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
final class LogAnalysisViewModel: ObservableObject {

    @Published var logText: String = ""
    @Published var insights: [LogInsight] = []
    @Published var metrics: [Metric] = []
    @Published var isLoading = false
    @Published var successMessage: String?
    @Published var errorMessage: String?

    private let service: LogAnalysisService
        private let promptBuilder: LogPromptBuilding
        private let parser: MetricsParsing
        private let demo: MetricsDemoProviding

        init(
            service: LogAnalysisService,
            promptBuilder: LogPromptBuilding,
            parser: MetricsParsing,
            demo: MetricsDemoProviding
        ) {
            self.service = service
            self.promptBuilder = promptBuilder
            self.parser = parser
            self.demo = demo
        }

    func analyze() async {

        guard !logText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Please enter a log file."
            return
        }

        isLoading = true
        errorMessage = nil
        successMessage = nil

        let prompt = promptBuilder.makePrompt(for: logText)

        let result = await service.analyzeLog(prompt: prompt)

        switch result {

        case .success(let response):
            do {
                let parsed = try parser.parse(response)
                self.metrics = parsed
                if parsed.isEmpty {
                    self.metrics = demo.sampleMetrics
                    self.successMessage = "Showing demo data (parsing fallback)."
                } else {
                    self.successMessage = "Log analyzed successfully."
                }
            } catch {
                self.metrics = demo.sampleMetrics
                self.errorMessage = "Could not parse AI response."
                self.successMessage = "Showing demo data (parsing fallback)."
            }

        case .failure:
            self.metrics = demo.sampleMetrics
            self.successMessage = "Live API unavailable. Showing demo data."
        }

        isLoading = false
    }
}


