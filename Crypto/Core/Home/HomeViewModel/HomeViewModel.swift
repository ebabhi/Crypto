//
//  HomeViewModel.swift
//  Crypto
//
//  Created by ebpearls on 25/3/2024.
//

import Foundation
import SwiftUI
import Combine


class HomeViewModel : ObservableObject {
    
    @Published var coins : [CoinModel] = []
    @Published var portfoiliCoins : [CoinModel] = []
    @Published var searchText : String = ""
    @Published var statsictis : [StatisticModel]  = []
    
    @Published private var allCoins : [CoinModel] = []
    let coinDataService : CoinDataService = CoinDataService()
    let marketDataService : MarketDataService = MarketDataService()
    
    private var cancellabels : Set<AnyCancellable> = Set<AnyCancellable>();
    
    init() {
        getCoins()
        filterCoins()
        getStaticstic()
    }
    
    func getCoins() {
        coinDataService.getAllCoins{ [weak self] result in
            switch result {
            case .success(let coins):
                self?.allCoins = coins
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func filterCoins() {
        $searchText
            .combineLatest($allCoins)
            .debounce(for: .seconds(0.3), scheduler: RunLoop.main)
            .map {(keyword, coins) in
                guard !keyword.isEmpty else {return coins}
                
                return self.allCoins.filter { coin in
                    coin.name.lowercased().contains(keyword.lowercased()) ||
                    coin.symbol.lowercased().contains(keyword.lowercased())
                }
            }.sink { [weak self] coins in
                self?.coins = coins
            }.store(in: &cancellabels)
    }
    
    func getStaticstic () {
        marketDataService.getMarketData { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async{
                    if let self = self {
                        self.statsictis =  self.mapMarketDataToStats(data)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func mapMarketDataToStats(_ data : CoinMarketDataModel)-> [StatisticModel] {
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume =  StatisticModel(title: "Volume", value: data.volume, percentageChange: nil)
        let bitCoinDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance, percentageChange: nil)
        let portfolio = StatisticModel(title: "Portfolio", value: "0.0", percentageChange: 0.0)
        return[marketCap, volume, bitCoinDominance, portfolio];
    }
}
