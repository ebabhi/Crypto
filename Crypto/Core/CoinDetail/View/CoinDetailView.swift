//
//  CoinDetailView.swift
//  Crypto
//
//  Created by abhi abhi shake on 10/4/2024.
//

import SwiftUI

struct CoinDetailView: View {
    let coin : CoinModel
    
    @StateObject var coinDetailViewModel : CoinDetailViewModel
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    init(coin: CoinModel) {
        self.coin = coin
        _coinDetailViewModel = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
    }
    
    
    var body: some View {
        VStack(alignment:.leading){
            Text("")
                .frame(height: 150)
            
            
            Text("Overview")
                .foregroundStyle(Color.theme.accent)
                .font(.title)
                .bold()
            
            Divider()
            
            LazyVGrid(columns: columns,alignment: .leading) {
                ForEach(coinDetailViewModel.overViewInfo) { data in
                    StatisticView(stat: data,alignment: .leading)
                        .padding()
                }
            }
            
            Text("Additional")
                .foregroundStyle(Color.theme.accent)
                .font(.title)
                .bold()
            
            Divider()
            LazyVGrid(columns: columns,alignment: .leading) {
                ForEach(coinDetailViewModel.additionalInfo) { data in
                    StatisticView(stat: data,alignment: .leading)
                        .padding()
                }
            }
        }
        .padding()
        .navigationTitle(coin.name)
    }
}

#Preview {
    NavigationStack{
        CoinDetailView(coin: DeveloperPreview.instance.coin)
    }
    
}

