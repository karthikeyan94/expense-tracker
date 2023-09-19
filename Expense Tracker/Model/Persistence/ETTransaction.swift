//
//  ETTransaction.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 28/07/23.
//

import SwiftUI
import SwiftData

@Model
class ETTransaction: Identifiable, Codable, Hashable {
    
    @Attribute(.unique) var id: String
    var amount: Double
    var date: Date
    var type: ETTransactionType
    var category: ETTransactionCategory
    var group: ETTransactionGroup
    var comment: String?
    
    init(amount: Double, date: Date, type: ETTransactionType, category: ETTransactionCategory, group: ETTransactionGroup, comment: String? = nil) {
        self.id = UUID().uuidString
        self.amount = amount
        self.date = date
        self.type = type
        self.category = category
        self.group = group
        self.comment = comment
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case amount
        case date
        case type
        case category
        case group
        case comment
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        amount = try container.decode(Double.self, forKey: .amount)
        date = try container.decode(Date.self, forKey: .date)
        type = try container.decode(ETTransactionType.self, forKey: .type)
        category = try container.decode(ETTransactionCategory.self, forKey: .category)
        group = try container.decode(ETTransactionGroup.self, forKey: .group)
        comment = try container.decodeIfPresent(String.self, forKey: .comment)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(amount, forKey: .amount)
        try container.encode(date, forKey: .date)
        try container.encode(type, forKey: .type)
        try container.encode(category, forKey: .category)
        try container.encode(group, forKey: .group)
        try container.encodeIfPresent(comment, forKey: .comment)
    }
}
