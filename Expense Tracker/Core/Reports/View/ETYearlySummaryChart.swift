//
//  ETYearlySummaryChart.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 18/09/23.
//

import SwiftUI
import Charts
import SwiftData

struct ETYearlySummaryChart: View {
    
    @Query(sort: [SortDescriptor<ETMonthCashFlow>(\.date, order: .forward)])
    var months: [ETMonthCashFlow]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Income")
            Chart {
                ForEach(months) { month in
                    BarMark(
                        x: .value("Month", month.id),
                        y: .value("Amount", month.income)
                    )
                    .annotation {
                        Text("\(month.income.formatAmountOfRegionalCurrency())")
                            .font(.system(size: 12))
                    }
                    .foregroundStyle(Color(.systemOrange))
                }
            }
            .frame(height: 300)
            .chartScrollableAxes(.horizontal)
            .chartScrollPosition(x: .constant(3))
            .chartXVisibleDomain(length: 3)
            
            Text("Expenses")
                .padding(.top, 24)
            Chart {
                ForEach(months) { month in
                    AreaMark(
                        x: .value("Month", month.id),
                        y: .value("Amount", month.expenses)
                    )
                    .foregroundStyle(Color(.red))
                    .opacity(0.8)
                    
                    PointMark(
                        x: .value("Month", month.id),
                        y: .value("Amount", month.expenses)
                    )
                    .annotation {
                        Text("\(month.expenses.formatAmountOfRegionalCurrency())")
                            .font(.system(size: 12))
                    }
                    .foregroundStyle(Color(.red))
                    
                    LineMark(
                        x: .value("Month", month.id),
                        y: .value("Amount", month.expenses)
                    )
                    .foregroundStyle(Color(.red))
                }
            }
            .frame(height: 300)
            .chartScrollableAxes(.horizontal)
            .chartScrollPosition(x: .constant(3))
            .chartXVisibleDomain(length: 3)
            
            Text("Savings")
                .padding(.top, 24)
            Chart {
                ForEach(months) { month in
                    
                    AreaMark(
                        x: .value("Month", month.id),
                        y: .value("Amount", month.income - month.expenses)
                    )
                    .foregroundStyle(Color(.green))
                    
                    PointMark(
                        x: .value("Month", month.id),
                        y: .value("Amount", month.income - month.expenses)
                    )
                    .annotation {
                        Text("\((month.income - month.expenses).formatAmountOfRegionalCurrency())")
                            .font(.system(size: 12))
                    }
                    .foregroundStyle(Color(.green))
                }
            }
            .frame(height: 300)
            .chartScrollableAxes(.horizontal)
            .chartScrollPosition(x: .constant(3))
            .chartXVisibleDomain(length: 3)
        }
    }
}

#Preview {
    ScrollView {
        ETYearlySummaryChart()
    }
    .modelContainer(previewContainer)
}
