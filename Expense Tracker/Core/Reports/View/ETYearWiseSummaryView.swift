//
//  ETYearWiseSummaryView.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 18/09/23.
//

import SwiftUI

struct ETYearWiseSummaryView: View {
    
    var yearlySummary: [ETYearWiseSummary]
    
    @Environment(\.horizontalSizeClass) private var deviceSizeClass
    var isCompact: Bool { deviceSizeClass == .compact }
    
    var body: some View {
        VStack {
            HStack {
                Text("Summary")
                    .font(.title2.bold())
                    .foregroundStyle(.primary)
                Spacer()
            }
            .padding(.bottom, 8)
        }
        
        if isCompact {
            Table(of: ETYearWiseSummary.self) {
                TableColumn("Annual Summary") { summary in
                    if summary.year == -1 {
                        HStack {
                            Text("Year")
                            Spacer()
                            Text("Income")
                            Spacer()
                            Text("Expenses")
                            Spacer()
                            Text("Savings")
                        }
                        .foregroundColor(Color(.systemBlue))
                    } else {
                        HStack {
                            Text(String(describing: summary.year))
                            Spacer()
                            Text("\(summary.income.formatAmountOfRegionalCurrency())")
                            Spacer()
                            Text("\(summary.expenses.formatAmountOfRegionalCurrency())")
                            Spacer()
                            ETRupeeView(amount: summary.income - summary.expenses, fontSize: 10)
                        }
                        .font(.system(size: 12))
                    }
                }
            } rows: {
                TableRow(ETYearWiseSummary(year: -1, income: -1, expenses: -1))
                ForEach(yearlySummary.sorted(by: {$0.year > $1.year}))
            }
            .frame(minHeight: 200, maxHeight: 300)
        } else {
            Table(yearlySummary.sorted(by: {$0.year > $1.year})) {
                TableColumn("Year") { summary in
                    Text(String(describing: summary.year))
                }
                TableColumn("Income") { summary in
                    Text("\(summary.income.formatAmountOfRegionalCurrency())")
                }
                TableColumn("Expenses") { summary in
                    Text("\(summary.expenses.formatAmountOfRegionalCurrency())")
                }
                TableColumn("Savings") { summary in
                    ETRupeeView(amount: summary.income - summary.expenses, fontSize: 10)
                }
            }
            .frame(minHeight: 200, maxHeight: 300)
            .font(.system(size: 12))
        }
    }
}

#Preview {
    ETYearWiseSummaryView(yearlySummary: ETYearWiseSummary.getMockedSummary())
}
