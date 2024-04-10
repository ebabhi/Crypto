//
//  MarketDataService.swift
//  Crypto
//
//  Created by ebpearls on 4/4/2024.
//

import Foundation
import Combine

class MarketDataService {
    
    var cancellable : AnyCancellable?
    
    @Published var coinMarketData : CoinMarketDataModel?
    
    
    init() {
       getMarketData()
    }
    
    func getMarketData() {
        cancellable =  NetworkingManager
            .makeApiCall(GlobalDataModel.self, url: "https://api.coingecko.com/api/v3/global")
            .sink { completion in
                switch completion {
                case .finished:
                    break;
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] globalData in
                self?.coinMarketData = globalData.data
                self?.cancellable?.cancel()
            }
    }
    
}
