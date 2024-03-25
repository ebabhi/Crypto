//
//  CoinDataService.swift
//  Crypto
//
//  Created by Abhishek Ghimire on 25/03/2024.
//

import Foundation
import Combine



class CoinDataService {
    
    @Published var allCoins : [CoinModel] = []
    
    private var subscription : AnyCancellable?
    
    func getAllCoins()  {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {return}
        
        
        subscription =  URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data: Data, response: URLResponse) in
                guard let response =  response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] coins in
                self?.allCoins = coins
                self?.subscription?.cancel()
            }
    }
}
