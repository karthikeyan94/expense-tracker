//
//  DateExtension.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 26/07/23.
//

import SwiftUI

extension Date {
    
    func toETExpenseMonth() -> ETExpenseMonth {
        let dateComponents = Calendar
            .current
            .dateComponents(
                [.month, .year],
                from: self)
        
        let monthIndex = dateComponents.month ?? 0
        return ETExpenseMonth(
            month: ETMonth.allCases[(monthIndex > 0) ? (monthIndex - 1) : monthIndex],
            year: dateComponents.year ?? 0
        )
    }
    
    func formatTransaction() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy hh:mm a"
        return formatter.string(from: self)
    }
}
