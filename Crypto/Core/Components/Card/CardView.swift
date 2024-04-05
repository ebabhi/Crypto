//
//  CardView.swift
//  Crypto
//
//  Created by ebpearls on 5/4/2024.
//

import SwiftUI

struct CardView<T : View>: View {
    
    let title : String
    
    let subTitle : String
    
    let content : () ->  T
    
    init( content: @escaping () -> T) {
        self.content = content
    }
    
    var body: some View {
        VStack{
            content()
            Text(title)
                .lineLimit(1)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Text(subTitle)
                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    CardView()
}
