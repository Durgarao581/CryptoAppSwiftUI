//
//  CryptoSwiftUIApp.swift
//  CryptoSwiftUI
//
//  Created by Ganga Durgarao Kothapalli on 23/07/22.
//

import SwiftUI

@main
struct CryptoSwiftUIApp: App {
    @StateObject private var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
            
        }
    }
}
