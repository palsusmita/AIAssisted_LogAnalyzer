//
//  Metric.swift
//  AIAssisted_LogAnalyzer
//
//  Created by susmita on 28/01/26.
//

import Foundation

struct Metric: Identifiable {
    let id = UUID()
    let name: String
    let value: Double
    let explanation: String
}

