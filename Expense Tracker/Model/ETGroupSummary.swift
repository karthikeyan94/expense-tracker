//
//  ETCategorySummary.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 06/08/23.
//

import SwiftUI

struct ETGroupSummary: Identifiable, Hashable {
    var id = UUID()
    var group: ETTransactionGroup
    var amount: Double
}
