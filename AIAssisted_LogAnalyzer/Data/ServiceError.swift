//
//  ServiceError.swift
//  AIAssisted_LogAnalyzer
//
//  Created by susmita on 03/03/26.
//

import Foundation

// MARK: - Errors
enum ServiceError: LocalizedError {
    case invalidURL
    case invalidResponse
    case missingAPIKey

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid Gemini API URL."
        case .invalidResponse:
            return "Invalid response from Gemini."
        case .missingAPIKey:
            return "API key not matching or it is missing."
        }
    }
}
