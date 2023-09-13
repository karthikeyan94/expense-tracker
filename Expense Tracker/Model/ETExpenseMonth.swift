//
//  ETExpenseMonth.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 26/07/23.
//

import Foundation

struct ETExpenseMonth {
    let month: ETMonth
    let year: Int
    
    init(month: ETMonth, year: Int) {
        self.month = month
        self.year = year
    }
    
    init?(of expenseMonthLiteral: String) {
        let parts = expenseMonthLiteral.split(separator: " ")
        if parts.count != 2 {
            return nil
        }
        self.month = ETMonth.getMonth(month: String(describing: parts[0]))
        self.year = Int(parts[1]) ?? 0
    }
    
    var string: String {
        "\(self.month.rawValue) \(self.year)"
    }
}
