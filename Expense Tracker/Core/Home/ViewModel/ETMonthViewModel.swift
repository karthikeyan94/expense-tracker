//
//  ETMonthViewModel.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 04/08/23.
//

import Foundation

class ETMonthViewModel: ObservableObject {
    
    @Published var expenseMonth: ETExpenseMonth
    
    @Published var monthCashflow: ETMonthCashFlow = ETMonthCashFlow(income: 0, expenses: 0)
    
    @Published var recentTransactions: [ETTransaction] = []
    
    init () {
        self.expenseMonth = Date().toETExpenseMonth()
    }
    
    init(for expenseMonth: ETExpenseMonth) {
        self.expenseMonth = expenseMonth
    }
}
