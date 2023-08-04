//
//  HomeView.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 24/07/23.
//

import SwiftUI
import Charts

struct ETHomeView: View {
    
    @StateObject var model = ETMonthViewModel()
    
    var body: some View {
        NavigationStack {
            ETMonthView(model: model)
            .navigationTitle(model.expenseMonth.string())
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
    let model = ETMonthViewModel()
    model.monthCashflow.income = 95590.16
    model.monthCashflow.expenses = 45325
    model.recentTransactions = ETTransaction.getMockTransactions()
    
    return ETHomeView(model: model)
}
