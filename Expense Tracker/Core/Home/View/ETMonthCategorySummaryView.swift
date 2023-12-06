//
//  ETMonthCategorySummaryView.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 07/08/23.
//

import SwiftUI
import Charts

struct ETMonthCategorySummaryView: View {
    
    var summary: [ETGroupSummary]
    
    var body: some View {
        VStack {
            HStack {
                Text("Statistics")
                    .font(.title2.bold())
                    .foregroundStyle(.primary)
                Spacer()
            }
            .padding(.bottom, 4)
            
            if #available(iOS 17.0, *) {
                Chart(summary, id: \.group) { groupSummary in
                    SectorMark(
                        angle: .value("Amount", groupSummary.amount),
                        angularInset: 1
                    )
                    .foregroundStyle(by: .value("Category", groupSummary.group.rawValue))
                    .cornerRadius(4)
                }
                .frame(height: 500)
                .chartLegend(alignment: .center)
                .padding()
                .padding(.horizontal, 8)
            } else {
                Chart(summary, id: \.group) { groupSummary in
                    BarMark(x: .value("Category", groupSummary.group.rawValue), y: .value("Amount", groupSummary.amount))
                }
            }
        }
        .padding(.vertical, 24)
    }
}

#Preview {
    ETMonthCategorySummaryView(summary: ETGroupSummary.getMockedSummary())
}
