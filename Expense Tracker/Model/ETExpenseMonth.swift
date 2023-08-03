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
    
    func string() -> String {
        return "\(self.month.rawValue) \(self.year)"
    }
}
