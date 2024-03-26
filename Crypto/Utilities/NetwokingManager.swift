//
//  NetwokingManager.swift
//  Crypto
//
//  Created by Abhishek Ghimire on 26/03/2024.
//

import Foundation
import Combine


class NetworkingManager {
    static func makeApiCall<T : Codable>(_ t : T.Type ,url : String) -> AnyPublisher<T,Error> {
        URLSession.shared.dataTaskPublisher(for: URL(string:url)!)
            .tryMap { (data: Data, response: URLResponse) in
                guard let response =  response as? HTTPURLResponse,
                      (200...399).contains(response.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
