//
//  MainViewModel+AgoraRtcEngineDelegate.swift
//  CallFriendProject
//
//  Created by оля on 08.05.2022.
//


import Foundation
import AgoraRtcKit

extension MainViewModel: AgoraRtcEngineDelegate {
  
  func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
    }
  
  func rtcEngine(_ engine: AgoraRtcEngineKit, didOfflineOfUid uid: UInt, reason: AgoraUserOfflineReason) {
      if call?.callType == .normal{
          self.hangUp()
      }
  }
}
