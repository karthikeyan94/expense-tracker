//
//  PreviewSampleData.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 09/08/23.
//

import SwiftUI
import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    do {
        
        let container = try ModelContainer(
            for: ETTransaction.self, ETMonthCashFlow.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        container.mainContext.insert(ETTransaction(amount: 116000, date: .now, type: .credit, category: .salary, group: .income, comment: "My salary"))
        container.mainContext.insert(ETTransaction(amount: 72184.16, date: .now, type: .credit, category: .salary, group: .income, comment: "Wife salary"))
        container.mainContext.insert(ETTransaction(amount: 9500, date: .now, type: .debit, category: .houseRent, group: .home))
        container.mainContext.insert(ETTransaction(amount: 800, date: .now, type: .debit, category: .houseMaintenance, group: .home))
        container.mainContext.insert(ETTransaction(amount: 90, date: .now, type: .debit, category: .milk, group: .provisions))
        container.mainContext.insert(ETTransaction(amount: 1400, date: .now, type: .debit, category: .groceries, group: .provisions))
        container.mainContext.insert(ETTransaction(amount: 350, date: .now, type: .debit, category: .snacksBeverages, group: .provisions))
        container.mainContext.insert(ETTransaction(amount: 199, date: .now, type: .debit, category: .netflix, group: .entertainment))
        container.mainContext.insert(ETTransaction(amount: 1178.82, date: .now, type: .debit, category: .broadbandJio, group: .utilities))
        container.mainContext.insert(ETTransaction(amount: 2895, date: .now, type: .debit, category: .vehicleMaintenance, group: .transportation))
        container.mainContext.insert(ETTransaction(amount: 600, date: .now, type: .debit, category: .oilChanges, group: .transportation))
        
        let monthCashflow: ETMonthCashFlow = ETMonthCashFlow(id: Date().formatExpenseMonth(), income: 116918.20, expenses: 45612.90, budget: 50000)
        container.mainContext.insert(monthCashflow)
        
        return container
    } catch {
        fatalError("Unable to populate preview model container")
    }
}()
