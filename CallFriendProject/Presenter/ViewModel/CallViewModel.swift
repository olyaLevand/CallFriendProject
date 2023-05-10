//
//  CallViewPresenter.swift
//  CallFriendProject
//
//  Created by Olya Levandivska on 27.04.2023.
//

import Foundation
import Combine
import SinchRTC

class CallViewModel: ObservableObject {
    
    var callMediator: CallMediator
    @Published var call: Call? 
    
    private var cancellables = Set<AnyCancellable>()
    
    init(callMediator: CallMediator) {
        self.callMediator = callMediator
        
        self.callMediator.$call
            .assign(to: \.call, on: self)
            .store(in: &cancellables)
    }
    
    func getUsername() -> String {
        return UserDefaults.standard.string(forKey: UserSettingKey.name)!
    }
    
    func acceptCall(){
        
    }
    
    func hangUpCall(){
        callMediator.hangup()
    }
        
}
