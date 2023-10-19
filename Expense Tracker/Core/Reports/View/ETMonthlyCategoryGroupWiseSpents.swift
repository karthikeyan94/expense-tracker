//
//  ETMonthlyCategoryGroupWiseSpents.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 17/09/23.
//

import SwiftUI

struct ETMonthlyCategoryGroupWiseSpents: View {
    var groupSummary: [ETGroupSummary]
    var categorySummary: [ETCategorySummary]
    var incomeSummary: [ETCategorySummary]
    
    var body: some View {
        VStack {
            HStack {
                Text("Summary")
                    .font(.title2.bold())
                    .foregroundStyle(.primary)
                Spacer()
            }
            .padding(.bottom, 8)
            
            if !incomeSummary.isEmpty {
                ETCategorySummaryView(title: "Income Category", categorySummary: incomeSummary)
                Spacer()
                    .frame(height: 30)
            }
            
            if !groupSummary.isEmpty {
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
                        
                        ForEach(groupSummary) { eachSummary in
                            VStack(alignment: .center){
                                HStack{
                                    Text(eachSummary.group.rawValue)
                                    Spacer()
                                    Text("\(eachSummary.amount.formatAmountOfRegionalCurrency())")
                                }
                                
                                if eachSummary != groupSummary.last {
                                    Divider()
                                }
                            }
                            .padding(.vertical, 8)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                
                Spacer()
                    .frame(height: 30)
            }
            
            if !categorySummary.isEmpty {
                ETCategorySummaryView(title: "Expense Category", categorySummary: categorySummary)
            }
        }
    }
}

struct ETCategorySummaryView: View {
    var title: String
    var categorySummary: [ETCategorySummary]
    
    var body: some View {
        ZStack {
            VStack {
                HStack{
                    Text(title)
                    Spacer()
                    Text("Amount")
                }
                .fontWeight(.semibold)
                .foregroundColor(Color(.systemBlue))
                
                Divider()
                
                ForEach(categorySummary) { eachSummary in
                    VStack(alignment: .center){
                        HStack{
                            Text(eachSummary.category.rawValue)
                            Spacer()
                            Text("\(eachSummary.amount.formatAmountOfRegionalCurrency())")
                        }
                        
                        if eachSummary != categorySummary.last {
                            Divider()
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

#Preview {
    ETMonthlyCategoryGroupWiseSpents(groupSummary: ETGroupSummary.getMockedSummary(), categorySummary: [], incomeSummary: [])
}
