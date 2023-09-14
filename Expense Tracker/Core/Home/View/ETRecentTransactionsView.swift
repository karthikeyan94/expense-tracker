//
//  ETRecentTransactionsView.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 03/08/23.
//

import SwiftUI
import SwiftData

struct ETRecentTransactionsView: View {
    
    var transactions: [ETTransaction]
    
    var isMoreTransactionsAvailable: Bool {
        return self.transactions.count > 3
    }
    
    var firstThreeTransactions: ArraySlice<ETTransaction> {
        if self.transactions.count > 3 {
            return self.transactions.prefix(upTo: 3)
        }
        
        return self.transactions.prefix(upTo: self.transactions.count)
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
                    ETTransactionsListView(transactions: transactions)
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
    let transactions: [ETTransaction] = []
    return ETRecentTransactionsView(transactions: transactions)
        .modelContainer(previewContainer)
}
