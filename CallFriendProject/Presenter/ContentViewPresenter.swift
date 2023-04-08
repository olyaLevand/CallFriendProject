//
//  ContentViewPresenter.swift
//  CallFriendProject
//
//  Created by Olya Levandivska on 07.04.2023.
//

import Foundation
import Combine

class ContentViewPresenter: ObservableObject {
    let router = AppRouter()

    @Published var state: AppRouter.RouterState = .login
    
    private var cancellables = Set<AnyCancellable>()

    init() {
        router.$state
            .assign(to: \.state, on: self)
            .store(in: &cancellables)
    }
    
    
    func goToMainScreen(){
        router.goToMainScreen()
    }
    
}
