//
//  ETYearWiseSummaryView.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 18/09/23.
//

import SwiftUI

struct ETYearWiseSummaryView: View {
    
    var yearlySummary: [ETYearWiseSummary]
    
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
        ZStack {
            ScrollView([.horizontal, .vertical]){
                VStack(alignment: .leading) {
                    HStack{
                        Text("Year")
                        Spacer()
                        Spacer()
                        Text("Income")
                        Spacer()
                        Spacer()
                        Text("Expenses")
                        Spacer()
                        Spacer()
                        Text("Savings")
                    }
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.systemBlue))
                    
                    Divider()
                    
                    ForEach(yearlySummary) { summary in
                        VStack(alignment: .center){
                            HStack{
                                Text(String(describing: summary.year))
                                Spacer()
                                Spacer()
                                Text("\(summary.income.formatAmountOfRegionalCurrency())")
                                Spacer()
                                Spacer()
                                Text("\(summary.expenses.formatAmountOfRegionalCurrency())")
                                Spacer()
                                Spacer()
                                ETRupeeView(amount: summary.income - summary.expenses, fontSize: 16)
                            }
                            
                            if summary != yearlySummary.last {
                                Divider()
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 200)
        }
        .padding()
        .background(Color(.systemGray6))
    }
}

#Preview {
    ETYearWiseSummaryView(yearlySummary: ETYearWiseSummary.getMockedSummary())
}
