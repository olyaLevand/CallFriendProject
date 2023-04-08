//
//  AppRouter.swift
//  CallFriendProject
//
//  Created by Olya Levandivska on 05.04.2023.
//

import Foundation
import Combine

class AppRouter: ObservableObject{
    
    enum RouterState{
        case login, main, call
    }
    
    @Published var state: RouterState = .login
    
    init(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.openMainScreen), name: Notification.Name(NotificationEvent.loggedIn.rawValue), object: nil)
    }
    
    func goToMainScreen(){
        NotificationCenter.default.post(name: Notification.Name(NotificationEvent.loggedIn.rawValue), object: nil)
    }
    
    @objc func openMainScreen(){
        self.state = .main
    }
    
    @objc func openLoginScreen(){
        self.state = .login
    }
    
    func openCallScreen(){
        self.state = .call
    }
    
}
