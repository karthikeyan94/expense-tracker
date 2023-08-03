//
//  ETTransaction.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 28/07/23.
//

import Foundation

struct ETTransaction: Codable, Identifiable, Hashable {
    var id = UUID()
    var amount: Double
    var transactionTimeMillis: TimeInterval
    var type: ETTransactionType
    var category: ETTransactionCategory
    var comment: String?
    
    var datetime: Date {
        return Date(timeIntervalSince1970: self.transactionTimeMillis)
    }
}
