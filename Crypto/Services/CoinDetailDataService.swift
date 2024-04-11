//
//  CoinDetailDataService.swift
//  Crypto
//
//  Created by ebpearls on 11/4/2024.
//

import Foundation
import Combine

class CoinDetailDataService : ObservableObject {
    
    @Published var coinDetail : CoinDetailModel?
    
    var anyCanellable : AnyCancellable?
    
    func getCoinDetail (coinid : String) {
        anyCanellable =  NetworkingManager.makeApiCall(CoinDetailModel.self, url: "https://api.coingecko.com/api/v3/coins/\(coinid)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")
            .sink { completion in
                switch completion {
                    
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            } receiveValue: { [weak self] data in
                self?.coinDetail = data
                self?.anyCanellable?.cancel()
            }
    }
}
