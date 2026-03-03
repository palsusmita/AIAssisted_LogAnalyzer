//
//  OpenRouterLogAnalysisService.swift
//  AIAssisted_LogAnalyzer
//
//  Created by susmita on 01/03/26.
//

import Foundation

final class OpenRouterLogAnalysisService: LogAnalysisService {

    private let config: OpenRouterConfig
    private let session: URLSession

    init(
        config: OpenRouterConfig,
        session: URLSession = .shared
    ) {
        self.config = config
        self.session = session
    }

    func analyzeLog(prompt: String) async -> Result<String, Error> {

        var request = URLRequest(url: config.baseURL)
        request.httpMethod = "POST"

        request.setValue("Bearer \(config.apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("LogAnalyzerApp", forHTTPHeaderField: "X-Title")

        let body: [String: Any] = [
            "model": config.model,
            "messages": [
                [
                    "role": "user",
                    "content": prompt
                ]
            ]
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)

            let (data, response) = try await session.data(for: request)
            if let raw = String(data: data, encoding: .utf8) {
                print("RAW Response:\n\(raw)")
            }
            guard
                let http = response as? HTTPURLResponse,
                http.statusCode == 200
            else {
                return .failure(ServiceError.invalidResponse)
            }

            guard
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                let choices = json["choices"] as? [[String: Any]],
                let message = choices.first?["message"] as? [String: Any],
                let content = message["content"] as? String
            else {
                return .failure(ServiceError.invalidResponse)
            }

            return .success(content)

        } catch {
            return .failure(error)
        }
    }
}
