//
//  ViewReactor.swift
//  ReactorKitPractice
//
//  Created by 권대윤 on 10/24/24.
//

import ReactorKit
import RxSwift

final class ViewReactor: Reactor {
    
    enum Action {
        case up
        case down
    }
    
    enum Mutation {
        case upValue
        case downValue
        case setLoding(Bool)
    }
    
    struct State {
        //현재값
        var value = 0
        var isLoding = false
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .up:
            return Observable.concat([
                Observable.just(Mutation.setLoding(true)),
                Observable.just(Mutation.upValue)
                    .delay(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoding(false)),
            ])
        
        case .down:
            return Observable.just(Mutation.downValue)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .upValue:
            newState.value += 1
            
        case .downValue:
            newState.value -= 1
            
        case .setLoding(let value):
            newState.isLoding = value
        }
        return newState
    }
}
