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
    
    @Published var allCoins : [CoinModel] = []
    @Published var portfoiliCoins : [CoinModel] = []
    
    let coinDataService : CoinDataService = CoinDataService()
    
//    private var cancellables : Set<AnyCancellable> =  Set<AnyCancellable>()
    
    
    init() {
        getCoins()
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
    
}
