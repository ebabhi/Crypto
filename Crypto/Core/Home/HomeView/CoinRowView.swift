//
//  CoinRowUIView.swift
//  Crypto
//
//  Created by ebpearls on 25/3/2024.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin : CoinModel
    
    var showHoldings : Bool
    
    var body: some View {
        HStack{
            Text("\(coin.rank)")
            Circle().frame(width: 45)
            Text(coin.symbol.uppercased(with: .autoupdatingCurrent))
            if showHoldings {
                Spacer()
                VStack{
                    Text("\(coin.currentHoldingsValue.format(.currency))")
                    Text("\(((coin.priceChangePercentage24H ?? 0.0) / 100).format(.percent))")
                }
            }
            Spacer()
            VStack(alignment:.trailing){
                Text("\(coin.currentPrice.format(.currency))")
                Text("\(((coin.priceChangePercentage24H ?? 0.0) / 100 ).format(.percent))")
                    .foregroundStyle(
                        (coin.priceChangePercentage24H ?? 0) <= 0 ?
                        Color.theme.red :Color.theme.green )
                
            }
        }
    }
}

struct CoinRowProvider : PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin,showHoldings: false)
    }
}
