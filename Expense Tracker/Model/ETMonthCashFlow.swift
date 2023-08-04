//
//  ETMonthCashFlow.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 26/07/23.
//

import Foundation

struct ETMonthCashFlow {
    var income: Double
    var expenses: Double
    var budget: Double?
    
    var netCashflow: Double {
        return self.income - self.expenses
    }
}
