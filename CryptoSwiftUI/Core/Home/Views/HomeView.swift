//
//  HomeView.swift
//  CryptoSwiftUI
//
//  Created by Ganga Durgarao Kothapalli on 23/07/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortafolio:Bool = false
    var body: some View {
        ZStack{
            //backgroundLayer
            Color.theme.background
                .ignoresSafeArea()
            
            
            //content layer
            
            VStack{
                homeHeader
                
                columnTitles
                if !showPortafolio{
                    allCoinList
                    .transition(.move(edge: .leading))
                }
                
                if showPortafolio{
                    portfolioCoinList
                        .transition(.move(edge: .trailing))
                }
                Spacer(minLength: 0)
            }
        }
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView{
            HomeView()
                .navigationBarHidden(true)
                
        }
        .environmentObject(dev.homeVM)
        
    }
}
extension HomeView{
    private var homeHeader: some View {
        HStack{
            CircleButton(iconName: showPortafolio ? "plus" : "info")
                .animation(.none)
                .background(
                CircleButtonAnimationView(animate: $showPortafolio)
                )
                
            Spacer()
            Text(showPortafolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
            Spacer()
            CircleButton(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortafolio ? 90 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortafolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
        
    }
    
    private var allCoinList: some View{
        List{
            
            ForEach(vm.allCoins){ coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 10, trailing: 10))
                
            }
            
        }
        .listStyle(.plain)
    }
    private var portfolioCoinList: some View{
        List{
            
            ForEach(vm.allCoins){ coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 10, trailing: 10))
                
            }
            
        }
        .listStyle(.plain)
    }
    
    private var columnTitles: some View{
        HStack{
            Text("Coin")
            Spacer()
            if showPortafolio{
                Text("Holding")
            }
           
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5,alignment: .trailing)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
