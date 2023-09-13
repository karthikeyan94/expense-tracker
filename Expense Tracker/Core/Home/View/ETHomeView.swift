//
//  HomeView.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 24/07/23.
//

import SwiftUI
import SwiftData

struct ETHomeView: View {
    
    @State private var expenseMonth:String = Date().toETExpenseMonth().string
    
    var body: some View {
        NavigationStack {
            ETMonthView(expenseMonth: $expenseMonth, _monthCashflows: monthCashflowQuery)
                .navigationTitle(expenseMonth)
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
        let predicate = #Predicate<ETMonthCashFlow> { $0.id == expenseMonth }
        
        return Query(filter: predicate)
    }
    
}

#Preview {
    ETHomeView()
        .modelContainer(previewContainer)
}
