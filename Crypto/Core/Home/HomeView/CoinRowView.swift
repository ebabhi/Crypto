//
//  CoinRowUIView.swift
//  Crypto
//
//  Created by ebpearls on 25/3/2024.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin : CoinModel
    
    var body: some View {
        HStack{
            Text("\(coin.rank)")
            Circle().frame(width: 45)
            Text(coin.symbol.uppercased(with: .autoupdatingCurrent))
            Spacer()
            VStack{
                Text("\(coin.currentHoldingsValue.format(.currency))")
                Text("\(((coin.priceChangePercentage24H ?? 0.0) / 100).format(.percent))")
            }
            Spacer()
            VStack(alignment:.trailing){
                Text("\(coin.currentPrice.format(.currency))")
                Text("\(((coin.priceChangePercentage24H ?? 0.0) / 100 ).format(.percent))")
            }
        }
    }
}

struct CoinRowProvider : PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin)
    }
}
