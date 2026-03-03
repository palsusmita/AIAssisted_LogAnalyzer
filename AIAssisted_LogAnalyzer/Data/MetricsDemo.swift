import Foundation

protocol MetricsDemoProviding {
    var sampleMetrics: [Metric] { get }
}

struct MetricsDemo: MetricsDemoProviding {
    var sampleMetrics: [Metric] {
        [
            Metric(name: "TotalRevenue",
                   value: 845000,
                   explanation: "Total revenue from successful transactions this month"),
            Metric(name: "TotalCost",
                   value: 610000,
                   explanation: "Operational and product costs"),
            Metric(name: "NetProfit",
                   value: 235000,
                   explanation: "Revenue minus cost"),
            Metric(name: "ProfitMargin",
                   value: 27.8,
                   explanation: "Net profit percentage"),
            Metric(name: "TotalTransactions",
                   value: 1240,
                   explanation: "Total transactions processed"),
            Metric(name: "SuccessfulTransactions",
                   value: 1136,
                   explanation: "Transactions that succeeded"),
            Metric(name: "FailedTransactions",
                   value: 104,
                   explanation: "Transactions that failed"),
            Metric(name: "FailureRate",
                   value: 8.4,
                   explanation: "Percentage of failed transactions"),
            Metric(name: "EstimatedNextMonthRevenue",
                   value: 912000,
                   explanation: "Projected revenue based on current trend"),
            Metric(name: "RiskLevel",
                   value: 35,
                   explanation: "Overall operational risk score")
        ]
    }
}
