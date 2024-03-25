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
}
