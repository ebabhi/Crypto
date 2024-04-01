//
//  SearchBarView.swift
//  Crypto
//
//  Created by Abhishek Ghimire on 31/03/2024.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var text : String
    
    @FocusState private var isFocused : Bool
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.theme.accent)
            
            TextField(text: $text){
                Text("Search coin")
            }
            .focused($isFocused)
            .foregroundStyle(Color.theme.accent)
            Spacer()
            if !text.isEmpty {
                Image(systemName: "xmark.circle.fill")
                    .padding(.all, 8)
                    .offset(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(Color.theme.accent)
                    .onTapGesture {
                        text = ""
                        isFocused = false
                    }
            }
            
        }
        .padding(.horizontal,10)
        .frame(height: 52)
        .background{
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.theme.background)
        }
        .padding(.horizontal,10)
        .shadow(color: Color.theme.accent.opacity(0.15), radius: 10, x :0, y: 0)
    }
}

#Preview {
    SearchBarView(text: .constant("aa"))
}
