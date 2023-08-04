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
    var color: Color?
    
    var textColor: Color {
        if let clr = color {
            return clr
        }
        if (self.amount < 0) {
            return Color(.systemRed)
        } else {
            return Color(.systemGreen)
        }
    }
    
    var body: some View {
        HStack {
            Text(amount.formatAmountOfRegionalCurrency())
        }
        .font(.system(size: CGFloat(fontSize), weight: .semibold))
        .foregroundColor(textColor)
    }
}

struct ETRupeeView_Previews: PreviewProvider {
    static var previews: some View {
        ETRupeeView(amount: 100.208566)
    }
}
