//
//  CallMediator+SinchAudioControllerDelegate.swift
//  CallFriendProject
//
//  Created by Olya Levandivska on 09.04.2023.
//

import Foundation
import SinchRTC

extension CallMediator: SinchAudioControllerDelegate {
  func audioControllerMuted(_ audioController: SinchAudioController) {
//    self.muted = true
  }

  func audioControllerUnmuted(_ audioController: SinchAudioController) {
//    self.muted = false
  }

  func audioControllerSpeakerEnabled(_ audioController: SinchAudioController) {}

  func audioControllerSpeakerDisabled(_ audioController: SinchAudioController) {}
}
