//
//  CallMediator+CXProviderDelegate.swift
//  CallFriendProject
//
//  Created by Olya Levandivska on 08.04.2023.
//

import Foundation
import CallKit
import AVFoundation

extension CallMediator: CXProviderDelegate {
    func providerDidReset(_ provider: CXProvider) {
        
    }
    
    func provider(_ provider: CXProvider, didActivate audioSession: AVAudioSession) {
      guard self.client != nil else {
        return
      }

      self.client!.callClient.provider(provider: provider, didActivateAudioSession: audioSession)
    }

    func provider(_ provider: CXProvider, didDeactivate audioSession: AVAudioSession) {
      guard self.client != nil else {
        return
      }

      self.client!.callClient.provider(provider: provider, didDeactivateAudioSession: audioSession)
    }
    
    
    func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
      defer {
        self.callStarted = nil
      }

      guard self.client != nil else {
        action.fail()
        return
      }

        let callResult = callType == .voice ?
        self.client!.callClient.callUser(withId: action.handle.value) :
        self.client!.callClient.videoCallToUser(withId: action.handle.value)
        
      switch callResult {
      case let .success(call):
          self.call = Call(state: .initiating , direction: .outgoing, callType: self.callType, destination: action.handle.value)
          self.call!.uuid = action.callUUID
          self.sinchCall = call
          AppRouter.goTpCallScreen()
          action.fulfill()
          call.delegate = self
      case let .failure(_):
          self.call = nil
        action.fail()
      }
      self.callStarted?(callResult)
        
        
    }
    
    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
      guard self.client != nil else {
        action.fail()
        return
      }

      self.client!.audioController.configureAudioSessionForCallKitCall()
        let call = self.call
        call?.state = .started
        self.call = call
        self.call?.uuid = action.callUUID
      sinchCall.answer()
      action.fulfill()
    }

    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
      guard self.client != nil else {
        action.fail()
        return
      }
      if let call = sinchCall{
          call.hangup()
      }
      action.fulfill()
        self.call = nil
    }
}
