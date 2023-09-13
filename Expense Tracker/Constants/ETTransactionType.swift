//
//  ETTransactionType.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 28/07/23.
//

import Foundation

enum ETTransactionType: String, CaseIterable, Codable {
    case credit = "Credit"
    case debit = "Debit"
}
