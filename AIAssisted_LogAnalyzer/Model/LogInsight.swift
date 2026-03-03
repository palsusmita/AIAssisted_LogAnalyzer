//
//  LogInsight.swift
//  AIAssisted_LogAnalyzer
//
//  Created by susmita on 28/01/26.
//
import Foundation

struct LogInsight: Identifiable, Decodable {
    let id = UUID()
    let title: String
    let description: String
}
