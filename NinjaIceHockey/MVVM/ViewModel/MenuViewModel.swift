//
//  MenuViewModel.swift
//  NinjaIceHockey
//
//  Created by Александр on 22.11.2022.
//

import Foundation
import RxSwift

class MenuViewModel {
    
    let items = PublishSubject<[Page]>()
    
    func fetchProductList() {        
        items.onNext(Page.allCases)
        items.onCompleted()
    }
    
}
