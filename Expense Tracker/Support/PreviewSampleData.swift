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
            configurations: ModelConfiguration(isStoredInMemoryOnly: true, allowsSave: true))
        
        let today: Date = .now
        let previousMonth: Date = Calendar.current.date(byAdding: .month, value: -1, to: today)!
        let transactions: [ETTransaction] = [
            ETTransaction(amount: 116000, date: previousMonth, type: .credit, category: .salary, group: .income, comment: "My salary"),
            ETTransaction(amount: 116000, date: today.addingTimeInterval(1 * 60), type: .credit, category: .salary, group: .income, comment: "My salary"),
            ETTransaction(amount: 72184.16, date: today.addingTimeInterval(2 * 60), type: .credit, category: .salary, group: .income, comment: "Wife salary"),
            ETTransaction(amount: 9500, date: today.addingTimeInterval(3 * 60), type: .debit, category: .houseRent, group: .home),
            ETTransaction(amount: 800, date: today.addingTimeInterval(4 * 60), type: .debit, category: .houseMaintenance, group: .home),
            ETTransaction(amount: 90, date: today.addingTimeInterval(5 * 60), type: .debit, category: .milk, group: .provisions),
            ETTransaction(amount: 1400, date: today.addingTimeInterval(6 * 60), type: .debit, category: .groceries, group: .provisions),
            ETTransaction(amount: 1178.82, date: today.addingTimeInterval(7 * 60), type: .debit, category: .broadbandJio, group: .utilities),
            ETTransaction(amount: 350, date: today.addingTimeInterval(8 * 60), type: .debit, category: .snacksBeverages, group: .provisions),
            ETTransaction(amount: 199, date: today.addingTimeInterval(9 * 60), type: .debit, category: .netflix, group: .entertainment),
            ETTransaction(amount: 2895, date: today.addingTimeInterval(10 * 60), type: .debit, category: .vehicleMaintenance, group: .transportation),
            ETTransaction(amount: 600, date: today.addingTimeInterval(11 * 60), type: .debit, category: .oilChanges, group: .transportation),
            ETTransaction(amount: 90, date: today.addingTimeInterval(12 * 60), type: .debit, category: .milk, group: .provisions),
            ETTransaction(amount: 350, date: today.addingTimeInterval(13 * 60), type: .debit, category: .snacksBeverages, group: .provisions)
        ]
        
        for transaction in transactions {
            container.mainContext.insert(transaction)
            
            let expenseMonthId = transaction.date.formatExpenseMonth()
            var monthCashFlows = try? container.mainContext.fetch(FetchDescriptor<ETMonthCashFlow>(predicate: #Predicate<ETMonthCashFlow> { $0.id == expenseMonthId }))
            var monthCashFlow = monthCashFlows?.last ?? ETMonthCashFlow(id: expenseMonthId, income: 0, expenses: 0)
            if  transaction.type == .credit {
                monthCashFlow.income = monthCashFlow.income + transaction.amount
            } else {
                monthCashFlow.expenses = monthCashFlow.expenses + transaction.amount
            }
            container.mainContext.insert(monthCashFlow)
        }
        
        return container
    } catch {
        fatalError("Unable to populate preview model container")
    }
}()
