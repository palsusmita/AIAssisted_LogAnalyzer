//
//  AppDIContainer.swift
//  AIAssisted_LogAnalyzer
//
//  Created by susmita on 03/03/26.
//

import Foundation
struct AppDIContainer {

    static func makeLogAnalysisViewModel() -> LogAnalysisViewModel {
        LogAnalysisViewModel(
            service: makeLogAnalysisService(),
            promptBuilder: makeLogPromptBuilder(),
            parser: makeMetricsParser(),
            demo: makeMetricsDemo()
        )
    }

    static func makeLogAnalysisService() -> LogAnalysisService {
                let apiKey = Bundle.main.object(
                    forInfoDictionaryKey: "API_KEY"
                ) as? String ?? ""

                let config = OpenRouterConfig(
                    baseURL: URL(string: "https://openrouter.ai/api/v1/chat/completions")!,
                    model: "openrouter/auto",
                    apiKey: apiKey
                )

                return OpenRouterLogAnalysisService(config: config)
            }

    static func makeLogPromptBuilder() -> LogPromptBuilding {
        LogPromptBuilder()
    }

    static func makeMetricsParser() -> MetricsParsing {
        MetricsParser()
    }

    static func makeMetricsDemo() -> MetricsDemoProviding {
        MetricsDemo()
    }
}
