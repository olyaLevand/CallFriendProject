//
//  ContentViewModel.swift
//  CallFriendProject
//
//  Created by оля on 06.04.2022.
//

import Foundation
import AgoraRtcKit
import SwiftUI
import UIKit

class ContentViewModel: ObservableObject{
    
    var dataCollector: DataCollector
    var mainViewModel: MainViewModel! = nil
    var loginViewModel: LoginViewModel
    @Published var state = CurrentState.login
    
    enum CurrentState{
        case login
        case main
    }
    
    
    init(){
        let collector = DataCollector()
        self.dataCollector = collector
        self.loginViewModel = LoginViewModel(dataCollector: collector)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.loggedInNotification(notification:)), name: Notification.Name(NotificationEvent.loggedIn.rawValue), object: nil)
        
    }
    
    
    @objc func loggedInNotification(notification: Notification) {
        guard let agoraCallKt = dataCollector.agoraCallKit else { return }
        self.mainViewModel = MainViewModel(agoraRtmCallKit: agoraCallKt)
        self.mainViewModel.setCallDelegate()
        self.state = CurrentState.main
        
    }

}







//class ContentViewModel: NSObject {
//
//    var agoraKit: AgoraRtcEngineKit? = nil
//    var localView = UIHostingController(rootView: ContentView())
//    var remoteView = UIHostingController(rootView: ContentView())
//
//    
//    override init(){
//        super.init()
//        initializeAndJoinChannel()
//    }
//    
//    private func initializeAndJoinChannel() {
//        
//      // Pass in your App ID here
//        agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: AppID.id, delegate: self)
//      // Video is disabled by default. You need to call enableVideo to start a video stream.
//      agoraKit?.enableVideo()
//           // Create a videoCanvas to render the local video
//           let videoCanvas = AgoraRtcVideoCanvas()
//           videoCanvas.uid = 0
//           videoCanvas.renderMode = .hidden
//        videoCanvas.view = localView.view
//           agoraKit?.setupLocalVideo(videoCanvas)
//
//      // Join the channel with a token. Pass in your token and channel name here
//      agoraKit?.joinChannel(byToken: nil, channelId: "demoChannel", info: nil, uid: 0, joinSuccess: { (channel, uid, elapsed) in
//           })
//       }
//}
//
//extension ContentViewModel: AgoraRtcEngineDelegate {
//    // This callback is triggered when a remote user joins the channel
//    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
//        let videoCanvas = AgoraRtcVideoCanvas()
//        videoCanvas.uid = uid
//        videoCanvas.renderMode = .hidden
//        videoCanvas.view = remoteView.view
//        agoraKit?.setupRemoteVideo(videoCanvas)
//    }
//}
