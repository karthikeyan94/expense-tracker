//
//  ETReportsView.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 15/09/23.
//

import SwiftUI
import SwiftData

struct ETReportsView: View {
    
    @State private var reportLayout: ETReportLayout = .monthly
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: [SortDescriptor<ETMonthCashFlow>(\.date, order: .reverse)])
    var months: [ETMonthCashFlow]
    
    var previousMonths: [ETMonthCashFlow] {
        let currentMonth = Date.now.formatExpenseMonth()
        return months.filter{ $0.id != currentMonth }
    }
    
    var yearlySummary: [ETYearWiseSummary] {
        let groupedYears = Dictionary(grouping: months) { monthCashflow in
            Calendar.current.component(.year, from: monthCashflow.date)
        }
        
        return groupedYears.map { year, cashflows in
            let totalIncome = cashflows.reduce(0.0) { $0 + $1.income }
            let totalExpenses = cashflows.reduce(0.0) { $0 + $1.expenses }
            return ETYearWiseSummary(year: year, income: totalIncome, expenses: totalExpenses)
        }
        .sorted(by: { $0.year < $1.year })
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Layout", selection: $reportLayout) {
                    ForEach(ETReportLayout.allCases) { layout in
                        Text(layout.rawValue.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                
                if reportLayout == .monthly {
                    if previousMonths.isEmpty {
                        ETReportsEmptyView()
                    } else {
                        List(previousMonths) { month in
                            NavigationLink(value: month) {
                                Text(month.id)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                        }
                        .listStyle(.plain)
                        .navigationDestination(for: ETMonthCashFlow.self) { month in
                            ETReportsMonthRouterView(month: month)
                                .navigationTitle(month.id)
                        }
                    }
                } else {
                    ScrollView {
                        if yearlySummary.isEmpty {
                            ETReportsEmptyView()
                        } else {
                            ETYearWiseSummaryView(yearlySummary: yearlySummary)
                            ETYearlySummaryChart()
                        }
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Reports")
            .padding()
        }
    }
}

struct ETReportsEmptyView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 4){
            Spacer()
            Image(systemName: "questionmark.circle")
                .renderingMode(.original)
                .font(.system(size: 40))
            Text("No Data")
            Spacer()
        }
    }
}

struct ETReportsMonthRouterView: View {
    var month: ETMonthCashFlow
    
    var monthTransactionQuery: Query<ETTransaction, [ETTransaction]> {
        let (startOfMonth, endOfMonth) = month.date.startAndEndOfMonth()
        let predicate = #Predicate<ETTransaction> { $0.date >= startOfMonth && $0.date <= endOfMonth}
        return Query(filter: predicate, sort: \.date, order: .reverse)
    }
    
    var body: some View {
        ETMonthView(monthCashflow: month, _transactions: monthTransactionQuery)
    }
}

#Preview {
    ETReportsView()
        .modelContainer(previewContainer)
}
