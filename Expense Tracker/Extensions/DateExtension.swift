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
        guard let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self)) else {
            fatalError("Unable to get start date from date")
        }
        guard let endOfMonth = Calendar.current.date(byAdding: DateComponents(month: 1, second: -1), to: startOfMonth) else {
            fatalError("Unable to get end date from date")
        }
        
        return (startOfMonth, endOfMonth)
    }
    
    static func expenseMonth(from expenseMonth: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.date(from: expenseMonth) ?? Date()
    }
}
