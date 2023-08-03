//
//  ETRupeeView.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 26/07/23.
//

import SwiftUI

struct ETRupeeView: View {
    let amount: Double
    var fontSize: Int = 20
    
    var isNegative: Bool {
        return self.amount < 0
    }
    
    var body: some View {
        HStack {
            Text(amount.formatAmountOfRegionalCurrency())
        }
        .font(.system(size: CGFloat(fontSize), weight: .semibold))
        .foregroundColor(isNegative ? Color(.systemRed) : Color(.systemGreen))
    }
}

struct ETRupeeView_Previews: PreviewProvider {
    static var previews: some View {
        ETRupeeView(amount: 100.208566)
    }
}
