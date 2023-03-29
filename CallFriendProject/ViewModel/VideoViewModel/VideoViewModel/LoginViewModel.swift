//
//  LoginViewModel.swift
//  CallFriendProject
//
//  Created by оля on 10.04.2022.
//

import Foundation
import AgoraRtmKit

class LoginViewModel{
    
    var dataCollector: DataCollector
    
    var agoraRtmkit = AgoraRtmKit(appId: AppID.id , delegate: nil)
    

    init(dataCollector: DataCollector){
        self.dataCollector = dataCollector
    }
    
    func login(username: String) -> Bool{
        agoraRtmkit?.login(byToken: nil, user: username) { [weak self] (errorCode) in
            guard errorCode == .ok else {
                return 
            }
            
            print("User logged in")
            self?.dataCollector.userName = username
            self?.dataCollector.agoraCallKit = self?.agoraRtmkit?.getRtmCall()
            self?.dataCollector.isLoggedIn = true
            NotificationCenter.default.post(name: Notification.Name(NotificationEvent.loggedIn.rawValue), object: nil)

//            self.setAgoraCallkit(AgoraRtm.kit?.getRtmCall())
            
//            print("logged in")
//            self.callKit = AgoraRtm.kit?.getRtmCall()
//            callKit?.callDelegate = self
//            AgoraRtm.status = .online
        }
        return true
    }
    
}
