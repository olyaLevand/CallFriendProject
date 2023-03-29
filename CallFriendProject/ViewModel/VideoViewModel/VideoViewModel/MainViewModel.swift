//
//  MainViewModel.swift
//  CallFriendProject
//
//  Created by оля on 10.04.2022.
//

import Foundation
import AgoraRtmKit
import CallKit
import AgoraRtcKit

class MainViewModel: NSObject, ObservableObject{
    
    @Published var call: Call? = nil
    
    private var agoraRtmCallKit: AgoraRtmCallKit
    private var agoraRtcKit: AgoraRtcEngineKit
    private var channelName = "demoChannel"
    
    private lazy var provider: CXProvider = {
      let provider = CXProvider(configuration: providerConfig)
      provider.setDelegate(self, queue: nil)
      
      return provider
    }()
    private lazy var providerConfig: CXProviderConfiguration = {
      let providerConfig = CXProviderConfiguration()
      providerConfig.supportsVideo = false
      providerConfig.maximumCallGroups = 1
      providerConfig.maximumCallsPerCallGroup = 1
      providerConfig.supportedHandleTypes = [.generic]

      return providerConfig
    }()
    
    var lastIncomingInvitation: AgoraRtmRemoteInvitation? = nil
    var lastOutgoingInvitation: AgoraRtmLocalInvitation? = nil

    init(agoraRtmCallKit: AgoraRtmCallKit){
        self.agoraRtmCallKit = agoraRtmCallKit
        self.agoraRtcKit = AgoraRtcEngineKit.sharedEngine(withAppId: AppID.id, delegate: nil)
    }
    
    func setCallDelegate(){
        self.agoraRtmCallKit.callDelegate = self
    }
    
    
    func startCall(to callees: String){
        let calleesArray = callees.components(separatedBy: " ")
        if calleesArray.count == 1{
            sendInvitation(to: calleesArray[0], callType: .normal)
        } else if calleesArray.count > 1{
            for userName in calleesArray {
                sendInvitation(to: userName, callType: .group)
            }
        }
    }
    
    func startVideo(to callee: String){
        sendInvitation(to: callee, callType: .video)
    }

    
    func sendInvitation(to calleeId: String, callType: Call.CallType){
      let invitation = AgoraRtmLocalInvitation(calleeId: calleeId)
      invitation.content = callType.rawValue

        self.agoraRtmCallKit.send(invitation) { [weak self] errorCode in
          guard errorCode == AgoraRtmInvitationApiCallErrorCode.ok else {
            print("fail to send invintation")
              return
          }
            
            self?.lastOutgoingInvitation = invitation
            self?.call = Call(state: Call.State.initiating, direction: Call.Direction.outgoing, callType: callType, caller: "Someone", callees: [calleeId], channelId: self?.channelName)
            
        print("success to send invintation")
    
      }
    }
    
    func acceptCall() {
        
      guard let remoteInvite = self.lastIncomingInvitation else { return }
        agoraRtmCallKit.accept(remoteInvite, completion: { [weak self] result in
        
            guard let self = self else { return }

            self.agoraRtcKit.joinChannel(byToken: nil, channelId: self.channelName, info: nil, uid: 0, joinSuccess: {(channel, uid, elapsed) in

                let lastCall = self.call
                self.call = Call(state: .started, direction: lastCall!.direction, callType: lastCall!.callType, caller: lastCall!.caller, callees: lastCall!.allCallees, channelId: lastCall!.chanelId)
                
          UIApplication.shared.isIdleTimerDisabled = true
        })
      })
    }
        
    
    private func refuseRemoteInvite(){
      guard let remoteInvite = self.lastIncomingInvitation else { return }
      agoraRtmCallKit.refuse(remoteInvite, completion: { _ in
      })
    }
    
    
    func startOutgoingCall(){
        self.call!.state = .started
        
        let lastCall = self.call
        self.call = Call(state: .started, direction: lastCall!.direction, callType: lastCall!.callType, caller: lastCall!.caller, callees: lastCall!.allCallees, channelId: self.channelName)
    }
    
    private func cancelLocalInvite(){
      guard let localInvite = self.lastOutgoingInvitation else { return }
      agoraRtmCallKit.cancel(localInvite, completion: { _ in
      })
    }
    
    func hangUp(){
        if self.call!.state == .started{
            leaveChannel()
        } else if call?.direction == .incomming && call?.state == .initiating{
            // refuse incomming call
            refuseRemoteInvite()
        }
        if call?.direction == .outgoing && call?.state == .initiating{
            cancelLocalInvite()
        }
        self.call = nil
    }
    
    func declinedCall(){
        self.call = nil
    }
    
    
    func getIncommingCall(callerName: String, callType: Call.CallType, channelId: String ){
        self.channelName = channelId
        self.call = Call(state: .initiating, direction: .incomming, callType: callType, caller: callerName, callees: [""], channelId: channelId)
    }
    
    private func leaveChannel() {
        agoraRtcKit.leaveChannel(nil)
    }
}

