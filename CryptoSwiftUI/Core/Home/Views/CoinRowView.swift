//
//  CoinRowView.swift
//  CryptoSwiftUI
//
//  Created by Ganga Durgarao Kothapalli on 23/07/22.
//

import SwiftUI

struct CoinRowView: View {
    let coin:CoinModel
    let showHoldingColumn:Bool
    var body: some View {
        
        HStack{
            leftColumnView
            Spacer()
            if showHoldingColumn{
                middleColumnView
            }
            rightColumnView
            
        }
        .font(.subheadline)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group{
            CoinRowView(coin: dev.coin, showHoldingColumn: true)
                .previewLayout(.sizeThatFits)
            CoinRowView(coin: dev.coin, showHoldingColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        
        
    }
}


extension CoinRowView{
    
    private var leftColumnView: some View{
        HStack(spacing: 0 ){
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading,6)
                .foregroundColor(Color.theme.accent)
        }
        
    }
    
    private var middleColumnView:some View{
        VStack(alignment: .trailing){
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString() )
        }
    }
    
    private var rightColumnView: some View{
        VStack(alignment:.trailing){
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundColor(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5,alignment: .trailing)
        
    }
}
