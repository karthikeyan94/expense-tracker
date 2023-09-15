//
//  ETAddTransactionView.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 14/09/23.
//

import SwiftUI
import SwiftData

struct ETAddTransactionView: View {
    
    @Bindable var monthCashflow: ETMonthCashFlow
    
    @Environment(\.modelContext) private var modelContext
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var amount: String = ""
    @State private var type: ETTransactionType = .debit
    @State private var category: ETTransactionCategory = .others
    @State private var comment: String = ""
    @State private var didError = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("Amount", text: $amount)
                            .keyboardType(.decimalPad)
                    }
                    
                    Section {
                        Picker("Type", selection: $type) {
                            ForEach(ETTransactionType.allCases) { transactionType in
                                Text(transactionType.rawValue.capitalized)
                            }
                        }
                        Picker("Category", selection: $category) {
                            ForEach(type.categories()) { transactionCategory in
                                Text(transactionCategory.rawValue.capitalized)
                                    .tag(transactionCategory)
                            }
                        }
                    } header: {
                        Text("Transaction")
                    }
                    
                    Section {
                        TextField("Comments", text: $comment)
                    } header: {
                        Text("Additional Information")
                    }
                }
            }
            .navigationTitle("Add Transaction")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        withAnimation {
                            guard let transactionAmount = Double(amount) else {
                                didError = true
                                return
                            }
                            let newTransaction = ETTransaction(amount: transactionAmount, date: .now, type: type, category: category, group: category.group())
                            let actualComment = comment.trimmingCharacters(in: .whitespacesAndNewlines)
                            if !actualComment.isEmpty {
                                newTransaction.comment = actualComment
                            }
                            modelContext.insert(newTransaction)
                            if newTransaction.type == .credit {
                                monthCashflow.income = monthCashflow.income + newTransaction.amount
                            } else {
                                monthCashflow.expenses = monthCashflow.expenses + newTransaction.amount
                            }
                            modelContext.insert(monthCashflow)
                            dismiss()
                        }
                    }
                    .bold()
                }
            }
            .alert(Text("Invalid amount"), isPresented: $didError) {
                Button("OK") {
                }
            } message: {
                Text("Please enter valid transaction amount!")
            }
        }
    }
}

#Preview {
    ETRootContentView()
        .modelContainer(previewContainer)
}
