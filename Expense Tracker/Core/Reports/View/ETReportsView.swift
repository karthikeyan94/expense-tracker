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
    
    var months: [ETMonthCashFlow] {
        let currentMonth = Date.now.formatExpenseMonth()
        let predicate = #Predicate<ETMonthCashFlow> { $0.id != currentMonth }
        let descriptor = FetchDescriptor(predicate: predicate, sortBy: [SortDescriptor(\.date, order: .reverse)])
        guard let previousMonths = try? modelContext.fetch(descriptor) else { return [] }
        return previousMonths
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
                    if months.isEmpty {
                        ETReportsEmptyView()
                    } else {
                        List(months) { month in
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
                    ETReportsEmptyView()
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
