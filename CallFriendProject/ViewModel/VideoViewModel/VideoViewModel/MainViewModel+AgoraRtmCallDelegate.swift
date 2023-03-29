//
//  MainViewModel+AgoraRtmCallDelegate.swift
//  CallFriendProject
//
//  Created by оля on 10.04.2022.
//

import Foundation
import AgoraRtmKit


extension MainViewModel: AgoraRtmCallDelegate {
  
    func rtmCallKit(_ callKit: AgoraRtmCallKit, localInvitationAccepted localInvitation: AgoraRtmLocalInvitation, withResponse response: String?) {
        print("rtmCallKit localInvitationAccepted")
        self.startOutgoingCall()
    }
    
    func rtmCallKit(_ callKit: AgoraRtmCallKit, localInvitationRefused localInvitation: AgoraRtmLocalInvitation, withResponse response: String?) {
        print("rtmCallKit localInvitationRefused")
        declinedCall()
    }
    
    func rtmCallKit(_ callKit: AgoraRtmCallKit, remoteInvitationReceived remoteInvitation: AgoraRtmRemoteInvitation) {
        
        self.lastIncomingInvitation = remoteInvitation
        let callType = Call.CallType(rawValue : remoteInvitation.content ?? "normal") ?? .normal
        self.getIncommingCall(callerName: remoteInvitation.callerId, callType: callType, channelId: remoteInvitation.channelId!)
        print("rtmCallKit remoteInvitationReceived")
    }
    
    func rtmCallKit(_ callKit: AgoraRtmCallKit, remoteInvitationCanceled remoteInvitation: AgoraRtmRemoteInvitation) {
        print("rtmCallKit remoteInvitationCanceled")
        declinedCall()
    }
    
    func rtmCallKit(_ callKit: AgoraRtmCallKit, localInvitationReceivedByPeer localInvitation: AgoraRtmLocalInvitation) {
        print("rtmCallKit localInvitationReceivedByPeer")
    }
    
    func rtmCallKit(_ callKit: AgoraRtmCallKit, localInvitationCanceled localInvitation: AgoraRtmLocalInvitation) {
        print("rtmCallKit localInvitationCanceled")
    }
    
    func rtmCallKit(_ callKit: AgoraRtmCallKit, localInvitationFailure localInvitation: AgoraRtmLocalInvitation, errorCode: AgoraRtmLocalInvitationErrorCode) {
        print("rtmCallKit localInvitationFailure: \(errorCode.rawValue)")
    }
    
    func rtmCallKit(_ callKit: AgoraRtmCallKit, remoteInvitationFailure remoteInvitation: AgoraRtmRemoteInvitation, errorCode: AgoraRtmRemoteInvitationErrorCode) {
        print("rtmCallKit remoteInvitationFailure: \(errorCode.rawValue)")
    }
    
    func rtmCallKit(_ callKit: AgoraRtmCallKit, remoteInvitationRefused remoteInvitation: AgoraRtmRemoteInvitation) {
        print("rtmCallKit remoteInvitationRefused")
    }
    
    func rtmCallKit(_ callKit: AgoraRtmCallKit, remoteInvitationAccepted remoteInvitation: AgoraRtmRemoteInvitation) {
        print("rtmCallKit remoteInvitationAccepted")
    }
}
