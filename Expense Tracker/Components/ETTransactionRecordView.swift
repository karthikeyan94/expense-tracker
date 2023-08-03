//
//  ETTransactionRecordView.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 28/07/23.
//

import SwiftUI

struct ETTransactionRecordView: View {
    
    let transaction: ETTransaction
    
    var body: some View {
        HStack {
            VStack {
                Image(transaction.category.getIconImageName())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.category.rawValue)
                Text(transaction.category.getGroup().rawValue)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                if let comment = transaction.comment {
                    Text(comment)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                Text(transaction.datetime.formatTransaction())
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding(.leading, 8)
            Spacer()
            ETRupeeView(
                amount: transaction.type == .debit ? (-1 * transaction.amount) : transaction.amount
            )
        }
    }
}

#Preview {
    ETTransactionRecordView(
        transaction:
            ETTransaction(
                amount: 199.99,
                transactionTimeMillis: Date().timeIntervalSince1970,
                type: .debit,
                category: .netflix
            )
    )
}
