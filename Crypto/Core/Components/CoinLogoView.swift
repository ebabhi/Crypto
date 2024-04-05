//
//  CoinLogoView.swift
//  Crypto
//
//  Created by ebpearls on 5/4/2024.
//

import SwiftUI

struct CoinLogoView: View {
    
    let coin : CoinModel
    
    
    var body: some View {
        VStack {
            CacheImageView(url: coin.image)
                .frame(height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
        }
    }
}

#Preview {
    CoinLogoView(coin: DeveloperPreview.instance.coin)
}
