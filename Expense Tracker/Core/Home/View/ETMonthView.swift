//
//  ETMonthView.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 04/08/23.
//

import SwiftUI
import SwiftData

struct ETMonthView: View {
    
    @Binding
    var expenseMonth:String
    
    @Environment(\.modelContext) private var modelContext
    
    var month: ETExpenseMonth? {
        guard let expMonth = ETExpenseMonth(of: expenseMonth) else { return nil }
        return expMonth
    }
    
    @Query
    var monthCashflows: [ETMonthCashFlow]
    
    var monthCashflow: ETMonthCashFlow {
        if let cashflow = monthCashflows.last {
            return cashflow
        }
        
        let expenseMonth = ETMonthCashFlow(id: expenseMonth, income: 0, expenses: 0)
        modelContext.insert(expenseMonth)
        return expenseMonth
    }
    
    var body: some View {
        ScrollView {
            ETMonthViewOverviewCard(monthCashflow: monthCashflow)
            ETMonthViewBudget(monthCashflow: monthCashflow)
            /* if model.recentTransactions.count > 0 {
             ETRecentTransactionsView(model: model)
             }
             if model.groupSummary.count > 0 {
             ETMonthCategorySummaryView(summary: model.groupSummary)
             }*/
        }
        .padding()
    }
}

struct ETMonthViewOverviewCard: View {
    
    @Bindable var monthCashflow: ETMonthCashFlow
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Total Balance")
                        .font(.system(size: 18, weight: .semibold))
                    Spacer()
                }
                HStack {
                    ETRupeeView(amount: monthCashflow.netCashflow)
                    Spacer()
                }
                Spacer()
                HStack {
                    VStack {
                        HStack {
                            Image(systemName: "triangle.fill")
                                .font(.system(size: 15))
                                .foregroundColor(.green)
                                .rotationEffect(.degrees(180))
                            Text("Income")
                                .font(.system(size: 15, weight: .semibold))
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        HStack {
                            Text("\(monthCashflow.income.formatAmountOfRegionalCurrency())")
                            Spacer()
                        }
                    }
                    Spacer()
                    VStack {
                        HStack {
                            Image(systemName: "triangle.fill")
                                .font(.system(size: 15))
                                .foregroundColor(.red)
                            Text("Expenses")
                                .font(.system(size: 15, weight: .semibold))
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        HStack {
                            Text("\(monthCashflow.expenses.formatAmountOfRegionalCurrency())")
                            Spacer()
                        }
                    }
                }
            }
        }
        .padding()
        .frame(width: .infinity, height: 150)
        .background(Color(.systemBlue))
        .cornerRadius(8)
    }
}

struct ETMonthViewBudget: View {
    
    @Bindable var monthCashflow: ETMonthCashFlow
    
    @State private var showAddBudget = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Budget")
                    .font(.title2.bold())
                    .foregroundStyle(.primary)
                Spacer()
            }
            .padding(.bottom, 4)
            
            if let budget = monthCashflow.budget {
                Gauge(value: monthCashflow.expenses, in: 0...budget) {
                    Text("Spent")
                } currentValueLabel: {
                    Text("\(monthCashflow.expenses.formatAmountOfRegionalCurrency())")
                }
                .tint(Gradient(colors: [.green, .yellow, .red]))
                
                if monthCashflow.expenses > budget {
                    ZStack {
                        HStack {
                            VStack {
                                Image(systemName: "exclamationmark.circle.fill")
                                    .renderingMode(.original)
                                    .font(.system(size: 50))
                            }
                            VStack {
                                Text("You have exceeded the maximum spending limit of \(budget.formatAmountOfRegionalCurrency())")
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(3)
                            }
                            .padding(.horizontal)
                            Spacer()
                        }
                    }
                    .padding()
                    .frame(width: .infinity, height: 100)
                    .background(Color(.systemOrange).opacity(0.4))
                    .cornerRadius(20)
                }
            } else {
                Image("budget")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(.bottom)
                Button {
                    showAddBudget.toggle()
                } label: {
                    Text("Allocate")
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(.vertical, 24)
        .sheet(isPresented: $showAddBudget, content: {
            ETAddBudgetView(monthCashflow: monthCashflow)
        })
    }
}

struct ETAddBudgetView: View {
    
    @Bindable var monthCashflow: ETMonthCashFlow
    
    @Environment(\.modelContext) private var modelContext
    
    @Environment(\.dismiss) private var dismiss
    
    @State var budget: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("Budget", text: $budget)
                            .keyboardType(.decimalPad)
                    }
                }
            }
            .navigationTitle("Add Budget")
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
                            if let budgetAmount = Double(budget) {
                                monthCashflow.budget = budgetAmount
                                modelContext.insert(monthCashflow)
                            }
                            dismiss()
                        }
                    }
                    .bold()
                }
            }
        }
    }
}

#Preview {
    @State var expenseMonth = Date().toETExpenseMonth().string
    return ETMonthView(expenseMonth: $expenseMonth)
        .modelContainer(previewContainer)
}
