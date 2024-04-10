//
//  CoinDetailView.swift
//  Crypto
//
//  Created by ebpearls on 10/4/2024.
//

import SwiftUI

struct CoinDetailView: View {
    
    let coin : CoinModel
    var body: some View {
        Text(coin.name)
    }
}

#Preview {
    CoinDetailView(coin: DeveloperPreview.instance.coin)
}

