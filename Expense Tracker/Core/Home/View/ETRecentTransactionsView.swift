//
//  ETRecentTransactionsView.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 03/08/23.
//

import SwiftUI

struct ETRecentTransactionsView: View {
    
    @StateObject var model: ETMonthViewModel
    
    var isMoreTransactionsAvailable: Bool {
        return self.model.recentTransactions.count > 3
    }
    
    var firstThreeTransactions: ArraySlice<ETTransaction> {
        if self.model.recentTransactions.count > 3 {
            return self.model.recentTransactions.prefix(upTo: 3)
        }
        
        return self.model.recentTransactions.prefix(upTo: self.model.recentTransactions.count)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Recent transactions")
                    .font(.title2.bold())
                    .foregroundStyle(.primary)
                Spacer()
            }
            .padding(.bottom, 4)
            
            ForEach(firstThreeTransactions) { transaction in
                ETTransactionRecordView(transaction: transaction)
                Divider()
            }
            
            if isMoreTransactionsAvailable {
                NavigationLink {
                    ETTransactionsListView(transactions: model.getTransactions())
                        .navigationTitle("Transactions")
                } label: {
                    Text("See all")
                }
            }
        }
        .padding(.vertical, 24)
    }
}

#Preview {
    let model = ETMonthViewModel(for: Date().toETExpenseMonth())
    model.monthCashflow.income = 95590.16
    model.monthCashflow.expenses = 45325
    model.recentTransactions = ETTransaction.getMockTransactions()
    
    return ETRecentTransactionsView(model: model)
}
