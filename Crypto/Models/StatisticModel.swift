//
//  StatisticModel.swift
//  Crypto
//
//  Created by Abhishek Ghimire on 02/04/2024.
//

import Foundation

struct StatisticModel : Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
}
