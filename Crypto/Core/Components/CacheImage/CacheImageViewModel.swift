//
//  CacheImageViewModel.swift
//  Crypto
//
//  Created by Abhishek Ghimire on 28/03/2024.
//

import Foundation
import SwiftUI


class ChacheImageViewModel : ObservableObject {
    
    @Published var image : UIImage?
    @Published var isLoading : Bool = false
    
    private static let folder = "coin_images"
    
    private var coinService =  CoinDataService()
    private var localFileManager = LocalFileManager()
    
    init(imageUrl: String) {
        Task{ await getImage(imageUrl) }
    }
    
    private func getImage(_ imageUrl : String) async {
        await MainActor.run {
            isLoading = true
        }
        let coinName = String(URL(string: imageUrl)!.lastPathComponent.split(separator: ".").first!) 
        
        guard let cacheImage  = localFileManager
            .getImage(name: coinName,folder: ChacheImageViewModel.folder)
        else {
            if let networkImage = await coinService.getCoinImage(imageUrl) {
                localFileManager
                    .setImage(image: networkImage, name: coinName, folder: ChacheImageViewModel.folder)
                await MainActor.run {
                    image = networkImage
                    print("From Network")
                }
                return
            }
            return
        }
        await MainActor.run {
            image = cacheImage
            print("From Cache")
            isLoading = false
        }
    }
}

