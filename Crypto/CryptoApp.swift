//
//  CryptoApp.swift
//  Crypto
//
//  Created by ebpearls on 25/3/2024.
//

import SwiftUI

@main
struct CryptoApp: App {
    
    @StateObject var homeViewModel : HomeViewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .environmentObject(homeViewModel)
    }
}
