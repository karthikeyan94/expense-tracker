//
//  ETMonthCashFlow.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 26/07/23.
//

import SwiftUI
import SwiftData

@Model
class ETMonthCashFlow: Hashable, Identifiable {
    @Attribute(.unique) var id: String
    var income: Double
    var expenses: Double
    var date: Date
    var budget: Double?
    
    var netCashflow: Double {
        return self.income - self.expenses
    }
    
    init(id: String, income: Double, expenses: Double, budget: Double? = nil) {
        self.id = id
        self.income = income
        self.expenses = expenses
        self.date = Date.expenseMonth(from: id)
        self.budget = budget
    }
}
