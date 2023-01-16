//
//  FavoritePokemonViewModel.swift
//  MyPokedex
//
//  Created by Nathaniel Andrian on 13/01/23.
//

import Foundation
import RxSwift
import RxCocoa

class FavoritePokemonViewModel {
    
    let disposeBag = DisposeBag()
    
    var item = BehaviorRelay<[FavoritePokemonModel]>(value: [])
    let refreshAction = PublishSubject<Void>()
    let refreshControlComplete = PublishSubject<Void>()
    
    init() {
        bind()
        refresh()
    }
    
    func bind() {
        item.accept([])
        readDataFromLocalDB()
        
    }
    
    private func refresh() {
        refreshAction.subscribe { [weak self] _  in
            self?.readDataFromLocalDBWhenRefresh()
        }.disposed(by: disposeBag)
    }
    
    func readDataFromLocalDB() {
        item.accept(LocalDBManager.shared.read())
    }
    
    func readDataFromLocalDBWhenRefresh() {
        item.accept(LocalDBManager.shared.read())
        refreshControlComplete.onNext(())
    }
}
