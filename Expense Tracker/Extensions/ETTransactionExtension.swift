//
//  ETTransactionExtension.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 03/08/23.
//

import Foundation

extension ETTransaction {
    static func getMockTransactions() -> [ETTransaction] {
        return [
            .init(amount: 116000, transactionTimeMillis: Date().timeIntervalSince1970, type: .credit, category: .salary, group: .income),
            .init(amount: 9500, transactionTimeMillis: Date().timeIntervalSince1970, type: .debit, category: .houseRent, group: .home),
            .init(amount: 90, transactionTimeMillis: Date().timeIntervalSince1970, type: .debit, category: .milk, group: .provisions),
            .init(amount: 800, transactionTimeMillis: Date().timeIntervalSince1970, type: .debit, category: .houseMaintenance, group: .home),
            .init(amount: 1700, transactionTimeMillis: Date().timeIntervalSince1970, type: .debit, category: .groceries, group: .provisions),
            .init(amount: 216, transactionTimeMillis: Date().timeIntervalSince1970, type: .debit, category: .snacksBeverages, group: .provisions),
            .init(amount: 199, transactionTimeMillis: Date().timeIntervalSince1970, type: .debit, category: .netflix, group: .entertainment),
            .init(amount: 1178.82, transactionTimeMillis: Date().timeIntervalSince1970, type: .debit, category: .broadbandJio, group: .utilities),
            .init(amount: 300, transactionTimeMillis: Date().timeIntervalSince1970, type: .debit, category: .fares, group: .transportation),
            .init(amount: 2000, transactionTimeMillis: Date().timeIntervalSince1970, type: .debit, category: .oilChanges, group: .transportation),
        ]
    }
}
