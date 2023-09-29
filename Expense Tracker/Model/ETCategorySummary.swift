//
//  ETCategorySummary.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 29/09/23.
//

import SwiftUI

struct ETCategorySummary: Identifiable, Hashable {
    var id = UUID()
    var category: ETTransactionCategory
    var amount: Double
}
