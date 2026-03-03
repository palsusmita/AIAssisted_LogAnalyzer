import Foundation

protocol MetricsParsing {
    func parse(_ text: String) throws -> [Metric]
}

enum MetricsParserError: Error {
    case empty
}

struct MetricsParser: MetricsParsing {
    func parse(_ text: String) throws -> [Metric] {
        let lines = text.components(separatedBy: .newlines)
        var results: [Metric] = []

        for line in lines {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            guard !trimmed.isEmpty else { continue }

            let parts = trimmed.components(separatedBy: "|")
            guard parts.count >= 3 else { continue }

            let name = parts[0].trimmingCharacters(in: .whitespaces)
            let valueString = parts[1].trimmingCharacters(in: .whitespaces)
            let explanation = parts[2...].joined(separator: "|")
                .trimmingCharacters(in: .whitespaces)

            let numericString = valueString.replacingOccurrences(of: ",", with: "")
            if let value = Double(numericString) {
                results.append(Metric(name: name, value: value, explanation: explanation))
            }
        }

        if results.isEmpty {
            throw MetricsParserError.empty
        }

        return results
    }
}
