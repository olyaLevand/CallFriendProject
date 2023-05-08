//
//  ContentViewPresenter.swift
//  CallFriendProject
//
//  Created by Olya Levandivska on 07.04.2023.
//

import Foundation
import Combine

class ContentViewPresenter: ObservableObject {
    
    let callMeadiator: CallMediator
    let router = AppRouter()

    @Published var state: AppRouter.RouterState = .preview
    private var cancellables = Set<AnyCancellable>()

    init(callMeadiator: CallMediator) {
        self.callMeadiator = callMeadiator
        router.$state
            .assign(to: \.state, on: self)
            .store(in: &cancellables)
    }
    
    func goToMainScreen(){
        AppRouter.goToMainScreen()
    }
    
}
