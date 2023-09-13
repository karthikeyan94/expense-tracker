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
            .init(amount: 116000, transactionDate: .now, type: .credit, category: .salary, group: .income),
            .init(amount: 9500, transactionDate: .now, type: .debit, category: .houseRent, group: .home),
            .init(amount: 90, transactionDate: .now, type: .debit, category: .milk, group: .provisions),
            .init(amount: 800, transactionDate: .now, type: .debit, category: .houseMaintenance, group: .home),
            .init(amount: 1700, transactionDate: .now, type: .debit, category: .groceries, group: .provisions),
            .init(amount: 216, transactionDate: .now, type: .debit, category: .snacksBeverages, group: .provisions),
            .init(amount: 199, transactionDate: .now, type: .debit, category: .netflix, group: .entertainment),
            .init(amount: 1178.82, transactionDate: .now, type: .debit, category: .broadbandJio, group: .utilities),
            .init(amount: 300, transactionDate: .now, type: .debit, category: .fares, group: .transportation),
            .init(amount: 2000, transactionDate: .now, type: .debit, category: .oilChanges, group: .transportation),
        ]
    }
}
