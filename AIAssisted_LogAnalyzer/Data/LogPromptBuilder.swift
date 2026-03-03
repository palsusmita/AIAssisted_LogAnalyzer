import Foundation

protocol LogPromptBuilding {
    func makePrompt(for log: String) -> String
}

struct LogPromptBuilder: LogPromptBuilding {
    func makePrompt(for log: String) -> String {
        """
        Analyze the following business log data.

        Extract financial metrics and calculate monthly performance.

        Return ONLY in this exact format:

        MetricName | NumericValue | Explanation

        Required Metrics:

        TotalRevenue | number | Total revenue from successful transactions
        TotalCost | number | Total cost associated with transactions
        NetProfit | number | Revenue minus cost
        ProfitMargin | number | Profit percentage (0-100)
        TotalTransactions | number | Count of all transactions
        SuccessfulTransactions | number | Count of successful transactions
        FailedTransactions | number | Count of failed transactions
        FailureRate | number | Percentage of failed transactions (0-100)
        EstimatedNextMonthRevenue | number | Forecasted revenue based on trend
        RiskLevel | number | Risk score from 0 (low) to 100 (high)

        Rules:
        - One metric per line
        - Value must be numeric only
        - No currency symbols
        - No extra text
        - If data is missing, estimate logically
        - Forecast using trend from available timestamps

        Log Data:
        \(log)
        """
    }
}
