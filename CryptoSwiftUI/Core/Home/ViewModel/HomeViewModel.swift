//
//  HomeViewModel.swift
//  CryptoSwiftUI
//
//  Created by Ganga Durgarao Kothapalli on 23/07/22.
//

import Foundation
import Combine


class HomeViewModel:ObservableObject{
    
    @Published var allCoins:[CoinModel] = []
    @Published var portfolioCoins:[CoinModel] = []
    
    private var dataservice = CoinDataService()
    private var cancellable = Set<AnyCancellable>()
    
    init(){
        addSubcribers()
    }
    
    func addSubcribers(){
        dataservice.$allCoins
            .sink { [weak self] (returnCoins) in
                self?.allCoins = returnCoins
            }
            .store(in: &cancellable)
            
    }
    
    
}
