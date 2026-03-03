import Foundation

protocol LogAnalysisService {
    func analyzeLog(prompt: String) async -> Result<String, Error>
}
