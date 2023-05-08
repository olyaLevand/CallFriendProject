//
//  MainViewPresenter.swift
//  CallFriendProject
//
//  Created by Olya Levandivska on 07.04.2023.
//

import Foundation
import Combine
import UIKit

class MainViewPresenter: ObservableObject{
    
    var callMediator: CallMediator
    
    func getUsername() -> String{
        return UserDefaults.standard.string(forKey: UserSettingKey.name)!
    }
    
    func connectButtonTapped(calleeName: String){
        callMediator.startOutgoingCall(to: calleeName, withCompletion: { _ in
        })
    }
    
    func clearUserData(){
        return UserDefaults.standard.set(nil, forKey: UserSettingKey.name)

    }
    
    init(callMeaditor: CallMediator){
        self.callMediator = callMeaditor
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor( .white )
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor( AppColors.darkBlueColor )], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    func setCallType(_ callType: CallType){
        callMediator.setCallType(callType)
    }
    
    func getActiveUsers(completion: @escaping ([String]) -> ()){
        DatabaseService.getActiveUsers(completion: {users in
            completion(users)
        })
    }
    
    func logout(){
        callMediator.logout()
        clearUserData()
        DatabaseService.setCurrentUserToInActive()
        AppRouter.goToLoginlScreen()
    }
}
