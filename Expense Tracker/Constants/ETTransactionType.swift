//
//  ETTransactionType.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 28/07/23.
//

import Foundation

enum ETTransactionType: String, CaseIterable, Codable, Identifiable {
    var id: Self {
        return self
    }
    
    case credit = "Credit"
    case debit = "Debit"
    
    func categories() -> [ETTransactionCategory] {
        var incomeCategories: [ETTransactionCategory] = [.salary, .reimbursement, .bonus, .dividend, .interetsEarned]
        switch self {
        case .credit:
            incomeCategories = incomeCategories.sorted{ $0.rawValue < $1.rawValue }
            incomeCategories.append(.others)
            return incomeCategories
        case .debit:
            var expenseCategories: [ETTransactionCategory] = []
            for category in ETTransactionCategory.allCases {
                if !incomeCategories.contains(category) {
                    expenseCategories.append(category)
                }
            }
            expenseCategories = expenseCategories.sorted{ $0.rawValue < $1.rawValue }
            expenseCategories.append(.others)
            
            return expenseCategories
        }
    }
}
