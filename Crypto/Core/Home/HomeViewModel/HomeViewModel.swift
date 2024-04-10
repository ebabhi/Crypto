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
    let portfolioDataService : PortfolioDataService = PortfolioDataService()
    
    private var cancellabels : Set<AnyCancellable> = Set<AnyCancellable>();
    
    init() {
        getCoins()
        filterCoins()
        getStaticstic()
        getPortfolio()
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
    
    func getStaticstic() {
        
        marketDataService
            .$coinMarketData
            .combineLatest($portfoiliCoins)
            .receive(on: DispatchQueue.main)
            .compactMap({ data , coins in
                guard data != nil else { return [] }
                return self.mapMarketDataToStats(data!,coins: coins)
            })
            .sink{ [weak self]  data in
                self?.statsictis = data
            }
            .store(in: &cancellabels)
    }
    
    func getPortfolio() {
        portfolioDataService
            .$portfolioEntity
            .combineLatest($coins)
            .map { entities, coins  in
                return  coins.compactMap { coin in
                    guard let entity = entities.first(where: {$0.id == coin.id}) else {return nil}
                    return coin.updateHoldings(amount: entity.quantity)
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] coins in
                self?.portfoiliCoins  = coins
            })
            .store(in: &cancellabels)
    }
    
    
    func updatePortfolio(_ model : CoinModel ,amount : Double) {
        portfolioDataService.updatePortfolio(model, amount: amount)
    }
    
    private func mapMarketDataToStats(_ data : CoinMarketDataModel, coins : [CoinModel])-> [StatisticModel] {
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume =  StatisticModel(title: "Volume", value: data.volume, percentageChange: nil)
        let bitCoinDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance, percentageChange: nil)
        
        let portfolioValue =
        coins
            .map({ $0.currentHoldingsValue })
            .reduce(0, +)
        
        let previousValue =
        coins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = coin.priceChangePercentage24H ?? 0 / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue)
        
        let portfolio = StatisticModel(
            title: "Portfolio",
            value: portfolioValue.format(.currency),
            percentageChange: percentageChange
        )
        
        
        return[marketCap, volume, bitCoinDominance, portfolio];
    }
}
