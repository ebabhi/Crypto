//
//  HomeViewModel.swift
//  Crypto
//
//  Created by ebpearls on 25/3/2024.
//

import Foundation
import SwiftUI


class HomeViewModel : ObservableObject {
    
    @Published var allCoins : [CoinModel] = []
    @Published var portfoiliCoins : [CoinModel] = []
    
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.allCoins = [DeveloperPreview.instance.coin]
        }
    }
    
}
