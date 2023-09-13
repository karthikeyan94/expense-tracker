//
//  ETMonthViewModel.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 04/08/23.
//

import Foundation

class ETMonthViewModel: ObservableObject {
    
    @Published var expenseMonth: ETExpenseMonth
    
    @Published var recentTransactions: [ETTransaction] = []
    
    @Published var groupSummary: [ETGroupSummary] = []
    
    init () {
        self.expenseMonth = Date().toETExpenseMonth()
    }
    
    init(for expenseMonth: ETExpenseMonth) {
        self.expenseMonth = expenseMonth
    }
    
    func getTransactions() -> [ETTransaction] {
        // TODO - Add method to fetch from firebase
        return ETTransaction.getMockTransactions()
    }
}
