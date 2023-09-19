//
//  ETMonthCashFlow.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 26/07/23.
//

import SwiftUI
import SwiftData

@Model
class ETMonthCashFlow: Hashable, Identifiable, Codable {
    @Attribute(.unique) var id: String
    var income: Double
    var expenses: Double
    var date: Date
    var budget: Double?
    
    var netCashflow: Double {
        return self.income - self.expenses
    }
    
    init(id: String, income: Double, expenses: Double, budget: Double? = nil) {
        self.id = id
        self.income = income
        self.expenses = expenses
        self.date = Date.expenseMonth(from: id)
        self.budget = budget
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case income
        case expenses
        case date
        case budget
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        income = try container.decode(Double.self, forKey: .income)
        expenses = try container.decode(Double.self, forKey: .expenses)
        date = try container.decode(Date.self, forKey: .date)
        budget = try container.decodeIfPresent(Double.self, forKey: .budget)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(income, forKey: .income)
        try container.encode(expenses, forKey: .expenses)
        try container.encode(date, forKey: .date)
        try container.encodeIfPresent(budget, forKey: .budget)
    }
}
