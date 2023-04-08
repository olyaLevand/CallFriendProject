//
//  LoginViewPresenter.swift
//  CallFriendProject
//
//  Created by Olya Levandivska on 07.04.2023.
//

import Foundation

class LoginViewPresenter{
    
    let router = AppRouter()
    
    private func saveUsername(username: String){
        UserDefaults.standard.set(username, forKey: UserSettingKey.name)
    }
    
    func loginButtonTap(username: String){
        guard !username.isEmpty else { return }
        saveUsername(username: username)
        router.goToMainScreen()
    }
}
