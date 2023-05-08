//
//  LoginViewPresenter.swift
//  CallFriendProject
//
//  Created by Olya Levandivska on 07.04.2023.
//

import Foundation
import Combine
import Firebase

class AuthViewPresenter: ObservableObject{
    
    let router = AppRouter()
    var callMediator: CallMediator
    
    @Published var showActivityIndicator = false

    init(callMediator: CallMediator){
        self.callMediator = callMediator
        Auth.auth().addStateDidChangeListener { auth, user in
            
        }
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
    
    private func loginToSinch(username: String, completion: @escaping () -> ()){
        guard !username.isEmpty else { return }
        createClient(username:username, completion:  { [weak self] in
            completion()
        })
    }
    
    private func getCurrentUsernameFormDB(completion: @escaping (String) -> () ) {
        DatabaseService.getCurrentUserName(resCompletion: {username in
            completion(username)
        })
    }
    
    func signUp(email: String, password: String, username: String, completionWithError: @escaping (String) -> ()) {
        showActivityIndicator = true
        Auth.auth().createUser(withEmail: email, password: password) {[weak self]  authResult, error in
            if error == nil {
                guard let userID = Auth.auth().currentUser?.uid else { return }
                DatabaseService.addUser(username: username, uid: userID)
                print("UserId after auth: \(userID)")
                self?.loginToSinch(username: username, completion: {
                    self?.saveUsername(username: username)
                    self?.showActivityIndicator = true
                    AppRouter.goToMainScreen()
                })
            }
            else {
                completionWithError(error!.localizedDescription)
            }
        }
    }
    
    func signIn(email: String, password: String, completionWithError: @escaping (String) -> ()){
        showActivityIndicator = true
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if error == nil{
                guard let self = self else { return }
                self.getCurrentUsernameFormDB(){username in
                    DatabaseService.setCurrentUserToActive()
                    self.loginToSinch(username: username, completion: {
                        self.saveUsername(username: username)
                        self.showActivityIndicator = false
                        AppRouter.goToMainScreen()
                    })
                }
            } else {
                completionWithError(error!.localizedDescription)
            }
        }
    }

}
