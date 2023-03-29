//
//  MainViewModel+CXProviderDelegate.swift
//  CallFriendProject
//
//  Created by оля on 15.04.2022.
//

import Foundation
import CallKit

extension MainViewModel: CXProviderDelegate {
    func providerDidReset(_ provider: CXProvider) {
      
    }
    
    func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
        
      action.fulfill()
    }

    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
  //    conferenceService.acceptCall()
  //    conferenceService.client.audioController()?.configureAudioSessionForCallKitCall()
      action.fulfill()
    }

    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
//      conferenceService.hangup(reason: AgoraCall.CallEndedReason.complited)
      action.fulfill()
    }
    
}
