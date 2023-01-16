//
//  PokedexViewModel.swift
//  MyPokedex
//
//  Created by Nathaniel Andrian on 13/01/23.
//

import Foundation
import RxSwift
import RxCocoa

final class PokedexViewModel {
    
    private let disposeBag = DisposeBag()
    var pokeData: [Pokemon] = []
    private var poke: [PokemonDetailRemote] = []
    let items = BehaviorRelay<[PokemonDetailRemote]>(value: [])
    let fetchMoreData = PublishSubject<Void>()
    let refreshControlAction = PublishSubject<Void>()
    let refreshControlComplete = PublishSubject<Void>()
    let isLoadingSpinnerAvailable = PublishSubject<Bool>()
    private var pageCounter = 1
    private var nextURL: URL? = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=10&offset=10")
    private var isPaginationRequestStillResume = false
    private var isRefreshRequestStillResume = false

    init() {
        bind()
    }
    
    private func bind() {
        fetchMoreData.subscribe { [weak self] _ in
            guard let self = self else { return }
            self.fetchData(isRefreshControl: false)
        } onError: { err in
            print(err)
        } onDisposed: {
            print("bind disposed")
        }.disposed(by: disposeBag)
        
        refreshControlAction.subscribe { [weak self] _ in
            self?.refreshControlTriggered()
        }.disposed(by: disposeBag)
    }
    
    func fetchData(isRefreshControl: Bool) {
        if isPaginationRequestStillResume || isRefreshRequestStillResume {
            return
        }
        
        self.isRefreshRequestStillResume = isRefreshControl
        
        if nextURL == nil {
            isPaginationRequestStillResume = true
            return
        }
        
        isPaginationRequestStillResume = true
        isLoadingSpinnerAvailable.onNext(true)
        
        guard nextURL != nil else {
            isPaginationRequestStillResume = true
            return
        }
        
        let request = Resource<PokedexPaginationRemoteModel>(url: nextURL!)
        URLRequest.loadData(resource: request).subscribe { data in
            self.nextURL = data.next
            self.doLoadDetails(data.results)
        } onFailure: { err in
            print(err)
        }.disposed(by: disposeBag)
    }
    
    func doLoadDetails(_ data: [Pokemon]) {
        data.forEach({
            let request = Resource<PokemonDetailRemote>(url: $0.url)
            URLRequest.loadData(resource: request).subscribe { data in
                self.poke.append(data)
            } onFailure: { err in
                print(err)
            }.disposed(by: disposeBag)
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.handleData()
            self.isLoadingSpinnerAvailable.onNext(false)
            self.isPaginationRequestStillResume = false
            self.isRefreshRequestStillResume = false
            self.refreshControlComplete.onNext(())
        })
    }
    
    private func handleData() {
        if pageCounter == 1 {
            items.accept(poke)
        } else {
            let oldData = items.value
            items.accept(oldData + poke)
            
        }
        poke.removeAll()
        pageCounter += 1
    }

    private func refreshControlTriggered() {
        isPaginationRequestStillResume = false
        pageCounter = 1
        items.accept([])
        fetchData(isRefreshControl: true)
    }
}
