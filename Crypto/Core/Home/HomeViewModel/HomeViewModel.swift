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
    
    private var cancellables : Set<AnyCancellable> =  Set<AnyCancellable>()
    
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        coinDataService.getAllCoins()
        coinDataService.$allCoins
            .receive(on: DispatchQueue.main)
            .sink { [weak self] allCoins in
                self?.allCoins = allCoins
            }
            .store(in: &cancellables)
    }
    
}
