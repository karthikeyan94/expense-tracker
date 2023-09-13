//
//  ExpenseTrackerApp.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 21/07/23.
//

import SwiftUI
import SwiftData

@main
struct ExpenseTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ETRootContentView()
        }
        .modelContainer(for: [
            ETTransaction.self,
            ETMonthCashFlow.self
        ])
    }
}
