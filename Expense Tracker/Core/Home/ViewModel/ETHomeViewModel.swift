//
//  ETHomeViewModel.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 26/07/23.
//

import Foundation

class ETHomeViewModel: ObservableObject {
    
    @Published var expenseMonth: ETExpenseMonth
    
    @Published var monthCashflow: ETMonthCashFlow = ETMonthCashFlow(income: 0, expenses: 0)
    
    init() {
        self.expenseMonth = Date().toETExpenseMonth()
    }
}
