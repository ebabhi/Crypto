//
//  CoinDetailViewModel.swift
//  Crypto
//
//  Created by ebpearls on 11/4/2024.
//

import Foundation
import Combine

class CoinDetailViewModel : ObservableObject {
    @Published var coinDetail : CoinDetailModel?
    
    @Published var overViewInfo : [StatisticModel] = []
    @Published var additionalInfo : [StatisticModel] = []
    
    let coinDetailDataService : CoinDetailDataService
    var cacnellables : Set<AnyCancellable> = Set<AnyCancellable>()
    
    let coinModel : CoinModel
    
    init(coin : CoinModel) {
        coinDetailDataService = CoinDetailDataService()
        coinModel = coin
        coinDetailDataService.getCoinDetail(coinid: coin.id)
        getCoinDetail()
    }
    
    func getCoinDetail () {
        coinDetailDataService
            .$coinDetail
            .map({(coinDetailModel) -> (overview: [StatisticModel],additional:[StatisticModel]) in

                let overviewArray = self.overViewDetail(coinDetailModel: coinDetailModel)
                let additionalArray = self.additionalDetail(coinDetailModel:coinDetailModel)
            
               return (overviewArray,additionalArray)
            })
            .receive(on: RunLoop.main)
            .sink { [weak self] data in
                print("LOADED")
                self?.overViewInfo = data.overview
                self?.additionalInfo = data.additional
            }
            .store(in: &cacnellables)
    }
    
    
    func overViewDetail(coinDetailModel:CoinDetailModel?) -> [StatisticModel] {
        let price = "$" + self.coinModel.currentPrice.formattedCurrenciesRepresentation()
        let pricePercentChange = self.coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
        
        let marketCap = "$" + (self.coinModel.marketCap?.formattedCurrenciesRepresentation() ?? "")
        let marketCapPercentChange = self.coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentChange)
        
        let rank = "\(self.coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank,percentageChange: nil)
        
        let volume = "$" + (self.coinModel.totalVolume?.formattedCurrenciesRepresentation() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume,percentageChange: nil)
        
        let overviewArray: [StatisticModel] = [
            priceStat, marketCapStat, rankStat, volumeStat
        ]
        
        return overviewArray
    }
    
    func additionalDetail(coinDetailModel:CoinDetailModel?) -> [StatisticModel] {
        let high = "$" + (self.coinModel.high24H?.formattedCurrenciesRepresentation() ?? "") 
        let highStat = StatisticModel(title: "24h High", value: high,percentageChange: nil)
        
        let low = self.coinModel.low24H?.formattedCurrenciesRepresentation() ?? "n/a"
        let lowStat = StatisticModel(title: "24h Low", value: low,percentageChange: nil)
        
        let priceChange = self.coinModel.priceChange24H?.formattedCurrenciesRepresentation() ?? "n/a"
        let pricePercentChange = self.coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange)
        
        let marketCapChange = "$" + (self.coinModel.marketCapChange24H?.formattedCurrenciesRepresentation() ?? "")
        let marketCapPercentChange = self.coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = StatisticModel(title: "Block Time", value: blockTimeString,percentageChange: nil)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing,percentageChange: nil)
        
        let additionalArray: [StatisticModel] = [
            highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
        ]
        
        return additionalArray
    }
}
