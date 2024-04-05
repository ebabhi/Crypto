//
//  CoinInfoTile.swift
//  Crypto
//
//  Created by ebpearls on 5/4/2024.
//

import SwiftUI

struct CoinInfoTile<T : View,F :View>: View {
    
    let leading :  T
    
    let trailing :  F
    
    var body: some View {
        HStack {
            leading
            Spacer()
            trailing
        }
    }
}



#Preview {
    CoinInfoTile(leading: Text("LEADING"), trailing: Text("TRAILING"))
}
