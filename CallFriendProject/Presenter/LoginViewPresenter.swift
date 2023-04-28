//
//  LoginViewPresenter.swift
//  CallFriendProject
//
//  Created by Olya Levandivska on 07.04.2023.
//

import Foundation

class LoginViewPresenter{
    
    let router = AppRouter()
    var callMediator: CallMediator
    
    init(callMediator: CallMediator){
        self.callMediator = callMediator
    }
    
    private func saveUsername(username: String){
        UserDefaults.standard.set(username, forKey: UserSettingKey.name)
    }
    
    private func createClient(username: String, completion: @escaping () -> () ){
        callMediator.createClient(withUserId: username, andCallback: {error in
            if error == nil{
                completion()
            }
        })
    }
    
    func loginButtonTap(username: String){
        guard !username.isEmpty else { return }
        createClient(username:username, completion:  { [weak self] in
            self?.saveUsername(username: username)
            AppRouter.goToMainScreen()
        })
    }
}
