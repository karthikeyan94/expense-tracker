//
//  ETMonthlyCategoryGroupWiseSpents.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 17/09/23.
//

import SwiftUI

struct ETMonthlyCategoryGroupWiseSpents: View {
    var summary: [ETGroupSummary]
    
    var sortedSummaries: [ETGroupSummary] {
        summary.sorted(by: { $0.amount > $1.amount } )
    }
    var body: some View {
        VStack {
            HStack {
                Text("Summary")
                    .font(.title2.bold())
                    .foregroundStyle(.primary)
                Spacer()
            }
            .padding(.bottom, 8)
            
            ZStack {
                VStack {
                    HStack{
                        Text("Expense Group")
                        Spacer()
                        Text("Amount")
                    }
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.systemBlue))
                    
                    Divider()
                    
                    ForEach(sortedSummaries) { eachSummary in
                        VStack(alignment: .center){
                            HStack{
                                Text(eachSummary.group.rawValue)
                                Spacer()
                                Text("\(eachSummary.amount.formatAmountOfRegionalCurrency())")
                            }
                            
                            if eachSummary != sortedSummaries.last {
                                Divider()
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
        }
    }
}

#Preview {
    ETMonthlyCategoryGroupWiseSpents(summary: ETGroupSummary.getMockedSummary())
}
