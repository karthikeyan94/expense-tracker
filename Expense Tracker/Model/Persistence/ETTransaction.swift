//
//  ETTransaction.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 28/07/23.
//

import SwiftUI
import SwiftData

@Model
class ETTransaction: Identifiable {
    
    @Attribute(.unique) var id: String
    var amount: Double
    var date: Date
    var type: ETTransactionType
    var category: ETTransactionCategory
    var group: ETTransactionGroup
    var comment: String?
    
    init(amount: Double, date: Date, type: ETTransactionType, category: ETTransactionCategory, group: ETTransactionGroup, comment: String? = nil) {
        self.id = UUID().uuidString
        self.amount = amount
        self.date = date
        self.type = type
        self.category = category
        self.group = group
        self.comment = comment
    }
}
