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
        case login, main, call, preview
    }
    
    @Published var state: RouterState = .preview
    
    init(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.openMainScreen), name: Notification.Name(NotificationEvent.loggedIn.rawValue), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.openCallScreen), name: Notification.Name(NotificationEvent.openCallView.rawValue), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.openLoginScreen), name: Notification.Name(NotificationEvent.openLoginScreen.rawValue), object: nil)
    }
    
    static func goToMainScreen(){
        NotificationCenter.default.post(name: Notification.Name(NotificationEvent.loggedIn.rawValue), object: nil)
    }
    
    static func goTpCallScreen(){
        NotificationCenter.default.post(name: Notification.Name(NotificationEvent.openCallView.rawValue), object: nil)
    }

    static func goToLoginlScreen(){
        NotificationCenter.default.post(name: Notification.Name(NotificationEvent.openLoginScreen.rawValue), object: nil)
    }
    
    @objc func openMainScreen(){
        self.state = .main
    }
    
    @objc func openLoginScreen(){
        self.state = .login
    }
    
    @objc func openCallScreen(){
        self.state = .call
    }
    
}
