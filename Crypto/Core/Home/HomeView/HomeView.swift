//
//  HomeView.swift
//  SwiftfulCrypto
//
//  Created by Nick Sarno on 5/8/21.
//

import SwiftUI

struct HomeView: View {
    
    @State  var showPortfolio : Bool = false
    
    var body: some View {
        VStack {
            homeHeader
            Spacer()
        }
    }
    
    
    var homeHeader : some View {
        return  HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .animation(.spring(), value: showPortfolio)
                .onTapGesture {
                    showPortfolio.toggle()
                }
               
        }
        .padding(.horizontal)
    }
}



#Preview {
    NavigationView {
        HomeView()
            .navigationBarHidden(true)
    }
}


