//
//  PortfolioView.swift
//  Crypto
//
//  Created by ebpearls on 4/4/2024.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    @State var selectedCoin : CoinModel? = DeveloperPreview.instance.coin
    
    @State var quantityText : String = ""
    
    var body: some View {
        NavigationStack{
            VStack {
                SearchBarView(text: $homeViewModel.searchText)
                coinList
                if let coin = selectedCoin {
                    VStack(spacing : 20) {
                        CoinInfoTile(leading: Text("Current price of \(coin.symbol.uppercased()):"),
                                     trailing: Text(coin.currentPrice.format(.currency)))
                        Divider()
                        CoinInfoTile(leading: Text("Amount Holdings:"),
                                     trailing: TextField("Eg : 1.4", text: $quantityText)
                            .multilineTextAlignment(.trailing))
                        .keyboardType(.decimalPad)
                        
                        Divider()
                        CoinInfoTile(leading: Text("Current Value:"),
                                     trailing: Text(getCurrentValue(coin.currentPrice).format(.currency)))
                        
                    }
                    .padding()
                    .font(.headline)
                }
                Spacer()
            }
            .navigationTitle("Edit Protfolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    DismissButton()
                }
                
                if let quantity = Double(quantityText), let coin = selectedCoin , quantity != coin.currentHoldings {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Save") {
                            withAnimation{
                                selectedCoin = nil
                                quantityText = ""
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PortfolioView()
        .environmentObject(DeveloperPreview.instance.homeViewModel)
}


extension PortfolioView {
    var coinList : some View {
        ScrollView(.horizontal,showsIndicators: false) {
            LazyHStack(spacing: 10){
                ForEach(homeViewModel.coins) { coin in
                    CoinLogoView(coin: coin)
                        .padding(.horizontal,8)
                        .padding(.vertical,8)
                        .frame(width: 75)
                        .background{
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.theme.green,
                                        lineWidth: selectedCoin?.id == coin.id ? 1 : 0)
                        }
                        .padding()
                        .onTapGesture {
                            withAnimation{
                                selectedCoin = coin
                            }
                        }
                }
            }
            .frame(height:120)
        }
    }
    
    
    func  getCurrentValue (_ amt : Double) -> Double {
        if let quantity = Double(quantityText) {
            return quantity * amt
        }
        return 0;
    }
}
