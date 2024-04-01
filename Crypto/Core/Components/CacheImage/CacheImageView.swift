//
//  CacheImageView.swift
//  Crypto
//
//  Created by Abhishek Ghimire on 28/03/2024.
//

import SwiftUI

struct CacheImageView: View {
    
    let url : String
    
    @StateObject var viewModel: ChacheImageViewModel
    
    init(url: String) {
        self.url = url
        _viewModel = StateObject(wrappedValue: ChacheImageViewModel(imageUrl: url))
    }
    var body: some View {
        if let image  =  viewModel.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }else if viewModel.isLoading{
            ProgressView()
        }else{
            Image(systemName: "questionmark")
                .foregroundStyle(Color.theme.secondaryText)
        }
    }
}

#Preview {
    CacheImageView(url: DeveloperPreview.instance.coin.image)
}
