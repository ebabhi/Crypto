//
//  HomeView.swift
//  SwiftfulCrypto
//
//  Created by Nick Sarno on 5/8/21.
//

import SwiftUI

struct HomeView: View {
    
    @State  var showPortfolio : Bool = false
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    var body: some View {
        VStack {
            homeHeader
            stats
            searchBar
            if showPortfolio {
                portfolioCoins
            }else{
                allCoins
            }
            
            Spacer()
        }
    }
    
    
    var homeHeader : some View {
        return  HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
                .animation(.none,value:showPortfolio)
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation{
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    
    var stats : some View {
        
        let stats: [StatisticModel] = DeveloperPreview.instance.statisticModels
        
        return HStack(alignment: .top){
            ForEach(stats) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3 ,alignment: .center)
            }
        }
        .frame(width: UIScreen.main.bounds.width,alignment: showPortfolio ? .trailing : .leading)
    }
    
    var searchBar : some View {
        SearchBarView(text: $homeViewModel.searchText)
    }
    
    var allCoins  : some View {
        List {
            ForEach(homeViewModel.coins) { coin in
                CoinRowView(coin: coin,showHoldings: false)
            }
        }
        .listStyle(PlainListStyle())
        .transition(.move(edge: .leading))
       
    }
    
    var portfolioCoins  : some View {
        List {
            ForEach(homeViewModel.portfoiliCoins) { coin in
                CoinRowView(coin: coin,showHoldings: true)
            }
        }
        .listStyle(PlainListStyle())
        .transition(.move(edge: .trailing))
    }
    
}




struct HomePreviewProvider : PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(dev.homeViewModel)
    }
}



