//
//  CoinMarketData.swift
//  Crypto
//
//  Created by ebpearls on 4/4/2024.
//

import Foundation

// MARK: - GlobalData
struct GlobalDataModel : Codable {
    let data: CoinMarketDataModel
    
    enum CodingKeys : String, CodingKey {
        case data = "data"
    }
}

// MARK: - CoinMarketData
struct CoinMarketDataModel : Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys : String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap : String {
        guard let (_ , value) =  totalMarketCap.filter({$0.key == "usd"}).first  else { return "" }
        return value.formattedCurrenciesRepresentation();
    }
    
    var volume : String {
        guard let (_ , value) =  totalVolume.filter({$0.key == "usd"}).first  else { return "" }
        return value.formattedCurrenciesRepresentation();
    }
    
    var btcDominance : String {
        guard let (_ , value) =  marketCapPercentage.filter({$0.key == "btc"}).first  else { return "" }
        return (value / 100).format(.percent);
    }
}

