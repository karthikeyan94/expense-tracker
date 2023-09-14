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
            ETMonthView(expenseMonth: expenseMonth, monthCashflow: monthCashflow)
                .navigationTitle(expenseMonth.formatExpenseMonth())
                .toolbar {
                    ToolbarItem {
                        Button {
                            //TODO : Handle new transaction
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 20))
                                .foregroundStyle(.blue)
                        }
                    }
                }
        }
    }
}

#Preview {
    ETHomeView()
        .modelContainer(previewContainer)
}
