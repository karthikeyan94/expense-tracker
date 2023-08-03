//
//  HomeView.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 24/07/23.
//

import SwiftUI
import Charts

struct ETHomeView: View {
    
    @StateObject var model = ETHomeViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Text("Cash flow")
                            .font(.title2.bold())
                            .foregroundStyle(.primary)
                        Spacer()
                    }
                    HStack {
                        VStack {
                            Chart {
                                BarMark(
                                    x: .value("Amount", model.monthCashflow.income),
                                    y: .value("Flow", "Income")
                                )
                                .foregroundStyle(Color.blue)
                                
                                BarMark(
                                    x: .value("Amount", model.monthCashflow.expenses),
                                    y: .value("Flow", "Expenses")
                                )
                                .foregroundStyle(Color.red)
                            }
                            .frame(width: 150, height: 100)
                            .chartXAxis(.hidden)
                            .chartYAxis(.hidden)
                        }
                        Spacer()
                        HStack {
                            ETRupeeView(amount: model.monthCashflow.netCashflow, fontSize: 28)
                        }
                    }
                    HStack {
                        Text("\(model.monthCashflow.income.formatAmountOfRegionalCurrency()) Earned")
                        Spacer()
                        Text("\(model.monthCashflow.expenses.formatAmountOfRegionalCurrency()) Spent")
                    }
                    .font(.callout)
                    .foregroundStyle(.secondary)
                }
                
                VStack {
                    HStack {
                        Text("Recent transactions")
                            .font(.title2.bold())
                            .foregroundStyle(.primary)
                        Spacer()
                    }
                    .padding(.bottom, 4)
                    
                    Section {
                        ForEach(0..<3) { index in
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Milk")
                                    Text(Date().formatTransaction())
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                    Text("Marriage gift")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                        .lineLimit(2)
                                        .multilineTextAlignment(.leading)
                                }
                                Spacer()
                                ETRupeeView(amount: -200)
                            }
                            Divider()
                        }
                    }
                    
                    NavigationLink {
                        Text("Transactions list")
                    } label: {
                        Text("See all")
                    }
                }
                .padding(.vertical, 24)
            }
            .padding()
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let model = ETHomeViewModel()
        model.monthCashflow.income = 95590.16
        model.monthCashflow.expenses = 45325
        
        return ETHomeView(model: model)
    }
}
