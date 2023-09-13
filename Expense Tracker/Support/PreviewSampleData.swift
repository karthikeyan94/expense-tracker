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
            for: [ETTransaction.self, ETMonthCashFlow.self],
            ModelConfiguration(inMemory: true)
        )
        
        for transaction in ETTransaction.getMockTransactions() {
            container.mainContext.insert(transaction)
        }
        
        let monthCashflow: ETMonthCashFlow = ETMonthCashFlow(id: Date().toETExpenseMonth().string, income: 116918.20, expenses: 45612.90, budget: 50000)
        container.mainContext.insert(monthCashflow)
        
        return container
    } catch {
        fatalError("Unable to populate preview model container")
    }
}()
