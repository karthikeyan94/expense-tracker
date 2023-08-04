//
//  ETRecentTransactionsView.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 03/08/23.
//

import SwiftUI

struct ETRecentTransactionsView: View {
    
    @Binding var transactions: [ETTransaction]
    
    var isMoreTransactionsAvailable: Bool {
        return transactions.count > 3
    }
    
    var firstThreeTransactions: ArraySlice<ETTransaction> {
        if transactions.count > 3 {
            return transactions.prefix(upTo: 3)
        }
        
        return transactions.prefix(upTo: transactions.count)
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
                    Text("Transactions list")
                } label: {
                    Text("See all")
                }
            }
        }
        .padding(.vertical, 24)
    }
}

#Preview {
    ETRecentTransactionsView(transactions: .constant(ETTransaction.getMockTransactions()))
}
