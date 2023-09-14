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
    
    var expenseMonthId: String {
        expenseMonth.formatExpenseMonth()
    }
    
    var monthName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: Date())
    }
    
    var body: some View {
        NavigationStack {
            ETMonthView(expenseMonth: expenseMonth, _monthCashflows: monthCashflowQuery, _transactions: monthTransactionQuery)
                .navigationTitle(monthName)
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
    
    var monthCashflowQuery: Query<ETMonthCashFlow, [ETMonthCashFlow]> {
        let predicate = #Predicate<ETMonthCashFlow> { $0.id == expenseMonthId }
        
        return Query(filter: predicate)
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
