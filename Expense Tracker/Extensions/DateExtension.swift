//
//  DateExtension.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 26/07/23.
//

import Foundation

extension Date {
    
    func formatExpenseMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: self)
    }
    
    func formatTransaction() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy hh:mm a"
        return formatter.string(from: self)
    }
    
    func startAndEndOfMonth() -> (start: Date, end: Date) {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        
        let startOfMonthComps = DateComponents(year: year, month: month, day: 1)
        let endOfMonthComps = DateComponents(year: year, month: month + 1, day: 0)
        
        return (calendar.date(from: startOfMonthComps)!, calendar.date(from: endOfMonthComps)!)
    }
    
    static func expenseMonth(from expenseMonth: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.date(from: expenseMonth) ?? Date()
    }
}
