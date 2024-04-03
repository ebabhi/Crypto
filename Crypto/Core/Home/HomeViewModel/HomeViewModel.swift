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
    
    @Published private var allCoins : [CoinModel] = []
    let coinDataService : CoinDataService = CoinDataService()
    
    private var cancellabels : Set<AnyCancellable> = Set<AnyCancellable>();
    
    init() {
//        getCoins()
//        filterCoins()
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
                    coin.name.lowercased().contains(keyword.lowercased())
                }
            }.sink { [weak self] coins in
                self?.coins = coins
            }.store(in: &cancellabels)
    }
    
}
