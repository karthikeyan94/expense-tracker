//
//  ETCategorySummaryExtension.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 06/08/23.
//

import Foundation

extension ETGroupSummary {
    static func getMockedSummary() -> [ETGroupSummary] {
        var summary: [ETGroupSummary] = []
        for group in ETTransactionGroup.allCases {
            if group == .income {
                continue
            }
            summary.append(.init(group: group, amount: 12500))
        }
        
        return summary
    }
}
