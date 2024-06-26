//
//  CoinDataService.swift
//  Crypto
//
//  Created by Abhishek Ghimire on 25/03/2024.
//

import Foundation
import Combine
import SwiftUI


class CoinDataService {
    
    private var subscription : AnyCancellable?
    
    func getAllCoins(completionHandler: @escaping (Result<[CoinModel],Error>)-> Void)  {
        let url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        
        subscription =  NetworkingManager.makeApiCall([CoinModel].self,url: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            } receiveValue: { [weak self] coins in
                completionHandler(.success(coins))
                self?.subscription?.cancel()
            }
    }
    
    func getCoinImage(_ url : String) async  ->  UIImage? {
        guard let url = URL(string: url) else { return nil }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        }
        catch{
            print(error.localizedDescription)
        }
        return nil
    }
}
