//
//  ETTransactionGroup.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 28/07/23.
//

import Foundation

enum ETTransactionGroup: String, CaseIterable, Codable, Identifiable {
    var id: Self {
        return self
    }
    
    case home = "Home"
    case utilities = "Utilities"
    case provisions = "Provisions"
    case clothings = "Clothings and Apparels"
    case education = "Education and Training"
    case healthcare = "Health Care"
    case transportation = "Transportation"
    case personal = "Personal"
    case gifts = "Gifts"
    case entertainment = "Entertainment"
    case vacation = "Vacation"
    case miscellaneous = "Miscellaneous"
    case income = "Incomes"
}
