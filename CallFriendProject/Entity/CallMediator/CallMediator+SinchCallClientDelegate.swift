//
//  CallMediator+SinchCallClientDelegate.swift
//  CallFriendProject
//
//  Created by Olya Levandivska on 08.04.2023.
//

import Foundation
import SinchRTC
import UIKit

extension CallMediator: SinchCallClientDelegate {
    func client(_ client: SinchCallClient, didReceiveIncomingCall call: SinchCall) {
        self.sinchCall = call
        call.delegate = self

        if UIApplication.shared.applicationState != .background {
          self.delegate.handleIncomingCall(call)
        }
        
        self.callType = call.details.isVideoOffered ? .video : .voice
        self.call = Call(state: .initiating, direction: .incomming, callType: self.callType, destination: call.remoteUserId)
    }
}
