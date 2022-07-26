//
//  CoinImageService.swift
//  CryptoSwiftUI
//
//  Created by Ganga Durgarao Kothapalli on 25/07/22.
//

import Foundation
import Combine
import SwiftUI

class CoinImageService{
    @Published var image: UIImage? = nil
    private var imageSubcription: AnyCancellable?
    private var coin:CoinModel
    
    init(coin:CoinModel){
        self.coin = coin
        getCoinImage()
        
    }
    
    private func getCoinImage(){
        guard let url = URL(
            string:coin.image) else {return}
        
        
        imageSubcription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: {[weak self] (returnedImage) in
                self?.image = returnedImage
                self?.imageSubcription?.cancel()
            })
        
        
    }
}
