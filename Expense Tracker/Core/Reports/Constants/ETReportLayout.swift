//
//  ETReportLayout.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 15/09/23.
//

import Foundation

enum ETReportLayout: String, CaseIterable, Codable, Identifiable {
    var id: Self {
        return self
    }
    
    case monthly = "Monthly"
    case yearly = "Yearly"
}
