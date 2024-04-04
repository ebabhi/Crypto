//
//  Double.swift
//  Crypto
//
//  Created by ebpearls on 25/3/2024.
//

import Foundation


extension Double {
    func format(_ style : NumberFormatter.Style ) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = style;
        numberFormatter.maximumFractionDigits = 2;
        return numberFormatter.string(from: NSNumber(value: self))!
    }
    
    func formattedCurrenciesRepresentation() -> String {
        let suffixes = ["", "K", "M", "B", "T"]
        var magnitude = 0
        var num = self
        while abs(num) >= 1000 {
            magnitude += 1
            num /= 1000.0
        }
        return String(format: "%.1f%@", num, suffixes[magnitude])
    }
}
