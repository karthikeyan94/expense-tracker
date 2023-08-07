//
//  ETTransactionsListView.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 06/08/23.
//

import SwiftUI

struct ETTransactionsListView: View {
    
    var transactions: [ETTransaction]
    
    var body: some View {
        List(transactions) { transaction in
            ETTransactionRecordView(transaction: transaction, fontSize: 12)
        }
    }
}

#Preview {
    ETTransactionsListView(transactions: ETTransaction.getMockTransactions())
}
