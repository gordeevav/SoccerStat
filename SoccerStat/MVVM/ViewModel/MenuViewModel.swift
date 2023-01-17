//
//  MenuViewModel.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 22.11.2022.
//

import RxSwift

final class MenuViewModel {
    
    public let items = PublishSubject<[Page]>()
    
    public func fetchProductList() {
        items.onNext(Page.allCases)
        items.onCompleted()
    }
    
}
