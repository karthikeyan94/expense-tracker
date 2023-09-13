//
//  ETMonth.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 24/07/23.
//

import Foundation

enum ETMonth: String, CaseIterable, Codable {
    case january = "January"
    case february = "February"
    case march = "March"
    case april = "April"
    case may = "May"
    case june = "June"
    case july = "July"
    case august = "August"
    case september = "September"
    case october = "October"
    case november = "November"
    case december = "December"
}

extension ETMonth {
    
    func getIndex() -> Int {
        return ETMonth.allCases.firstIndex(of: self) ?? 0
    }
    
    static func getMonth(month: String) -> ETMonth {
        ETMonth.allCases.first(where: {$0.rawValue == month}) ?? .january
    }
}
