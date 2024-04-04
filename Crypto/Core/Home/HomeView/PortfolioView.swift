//
//  PortfolioView.swift
//  Crypto
//
//  Created by ebpearls on 4/4/2024.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    var body: some View {
        NavigationStack{
            VStack {
                SearchBarView(text: $homeViewModel.searchText)
                Spacer()
            }
            .navigationTitle("Edit Protfolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    DismissButton()
                }
            }
        }
    }
}

#Preview {
    PortfolioView()
        .environmentObject(DeveloperPreview.instance.homeViewModel)
}
