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
    
    func getMarketData(_ handler : @escaping (Result<CoinMarketDataModel,Error>)-> Void) {
        cancellable =  NetworkingManager
            .makeApiCall(GlobalDataModel.self, url: "https://api.coingecko.com/api/v3/global")
            .sink { completion in
                switch completion {
                case .finished:
                    break;
                case .failure(let error):
                    handler(.failure(error))
                }
            } receiveValue: { [weak self] globalData in
                handler(.success(globalData.data))
                self?.cancellable?.cancel()
            }
    }
    
}
