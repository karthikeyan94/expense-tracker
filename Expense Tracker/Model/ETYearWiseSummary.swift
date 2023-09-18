//
//  ETYearWiseSummary.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 18/09/23.
//

import Foundation

struct ETYearWiseSummary: Identifiable, Hashable {
    var id = UUID().uuidString
    var year: Int
    var income: Double
    var expenses: Double
    
    static func getMockedSummary() -> [ETYearWiseSummary] {
        return [
            ETYearWiseSummary(year: 2020, income: 1500000, expenses: 750000),
            ETYearWiseSummary(year: 2021, income: 1800000, expenses: 900000),
            ETYearWiseSummary(year: 2022, income: 2200000, expenses: 1100000),
            ETYearWiseSummary(year: 2023, income: 1700000, expenses: 1150000),
        ]
    }
}
