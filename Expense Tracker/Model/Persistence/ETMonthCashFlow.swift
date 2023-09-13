//
//  ETMonthCashFlow.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 26/07/23.
//

import Foundation
import SwiftData

@Model
class ETMonthCashFlow {
    @Attribute(.unique) var id: String
    var income: Double
    var expenses: Double
    var budget: Double?
    
    var netCashflow: Double {
        return self.income - self.expenses
    }
    
    init(id: String, income: Double, expenses: Double, budget: Double? = nil) {
        self.id = id
        self.income = income
        self.expenses = expenses
        self.budget = budget
    }
}
