//
//  CurrencyExtension.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 26/07/23.
//

import Foundation

extension Double {
    
    func formatAmountOfRegionalCurrency(for locale: Locale? = nil) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = locale ?? Locale.current
        
        guard let formattedString = numberFormatter.string(from: NSNumber(value: self)) else {
            return ""
        }
        
        return formattedString
    }
}
