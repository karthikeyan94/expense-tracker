//
//  ETMonthView.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 04/08/23.
//

import SwiftUI

struct ETMonthView: View {
    
    @StateObject var model: ETMonthViewModel
    
    var body: some View {
        ScrollView {
            ETMonthViewOverviewCard(monthCashflow: $model.monthCashflow)
            ETMonthViewBudget(monthCashflow: $model.monthCashflow)
            if model.recentTransactions.count > 0 {
                ETRecentTransactionsView(model: model)
            }
            if model.groupSummary.count > 0 {
                ETMonthCategorySummaryView(summary: model.groupSummary)
            }
        }
        .padding()
    }
}

struct ETMonthViewOverviewCard: View {
    
    @Binding var monthCashflow: ETMonthCashFlow
    
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
    
    @Binding var monthCashflow: ETMonthCashFlow
    
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
                    
                } label: {
                    Text("Allocate")
                }
                .buttonStyle(.borderedProminent)
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
    model.groupSummary = ETGroupSummary.getMockedSummary()
    
    return ETMonthView(model: model)
}
