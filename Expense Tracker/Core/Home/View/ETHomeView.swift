//
//  HomeView.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 24/07/23.
//

import SwiftUI
import SwiftData

struct ETHomeView: View {
    
    @State private var expenseMonth: Date = Date()
    
    @State private var showAddTransaction = false
    
    @Environment(\.modelContext) private var modelContext
    
    var monthCashFlows: [ETMonthCashFlow] {
        let monthId = expenseMonth.formatExpenseMonth()
        guard let months = try? modelContext.fetch(FetchDescriptor<ETMonthCashFlow>(predicate: #Predicate<ETMonthCashFlow> { $0.id == monthId } )) else { return [] }
        return months
    }
    
    var monthCashflow: ETMonthCashFlow {
        if let cashflow = monthCashFlows.last {
            return cashflow
        }
        
        let expenseMonth = ETMonthCashFlow(id: expenseMonth.formatExpenseMonth(), income: 0, expenses: 0)
        modelContext.insert(expenseMonth)
        return expenseMonth
    }
    
    var body: some View {
        NavigationStack {
            ETMonthView(monthCashflow: monthCashflow, _transactions: monthTransactionQuery)
                .navigationTitle(expenseMonth.formatExpenseMonth())
                .toolbar {
                    ToolbarItem {
                        Button {
                            showAddTransaction.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 20))
                                .foregroundStyle(.blue)
                        }
                    }
                }
        }
        .sheet(isPresented: $showAddTransaction, content: {
            ETAddTransactionView(monthCashflow: monthCashflow)
        })
    }
    
    var monthTransactionQuery: Query<ETTransaction, [ETTransaction]> {
        let (startOfMonth, endOfMonth) = expenseMonth.startAndEndOfMonth()
        let predicate = #Predicate<ETTransaction> { $0.date >= startOfMonth && $0.date <= endOfMonth}
        return Query(filter: predicate, sort: \.date, order: .reverse)
    }
}

#Preview {
    ETHomeView()
        .modelContainer(previewContainer)
}
