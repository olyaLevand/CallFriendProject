//
//  CallMediator+SinchCallDelegate.swift
//  CallFriendProject
//
//  Created by Olya Levandivska on 08.04.2023.
//

import Foundation
import SinchRTC
import CallKit

extension CallMediator: SinchCallDelegate {
    private func fanoutDelegateCall(_ callback: (_ observer: CallKitMediatorObserver) -> Void) {

    }

    func callDidProgress(_ call: SinchCall) {

    }

    func callDidEstablish(_ call: SinchCall) {
        let call = self.call
        call?.state = .started
        self.call = call
    }

    func callDidEnd(_ call: SinchCall) {
        if let uuid = self.call?.uuid{
            self.provider.reportCall(with: uuid,
                                     endedAt: call.details.endedTime,
                                     reason: getCallKitCallEndedReason(forCause: call.details.endCause))
            }
        call.delegate = nil
        self.call = nil
        AppRouter.goToMainScreen()
    }

    func callDidAddVideoTrack(_ call: SinchCall) {
//      self.fanoutDelegateCall { $0.callDidAddVideoTrack(call) }
    }

    func callDidPauseVideoTrack(_ call: SinchCall) {
//      self.fanoutDelegateCall { $0.callDidPauseVideoTrack(call) }
    }

    func callDidResumeVideoTrack(_ call: SinchCall) {
//      self.fanoutDelegateCall { $0.callDidResumeVideoTrack(call) }
    }
  }

private func getCallKitCallEndedReason(forCause cause: SinchCallDetails.EndCause) -> CXCallEndedReason {
  switch cause {
  case .error:
    return .failed
  case .denied:
    return .remoteEnded
  case .hungUp:
    // This mapping is not really correct, as .hangUp is the end cause also when the local peer ended the
    // call.
    return .remoteEnded
  case .timeout:
    return .unanswered
  case .canceled:
    return .unanswered
  case .noAnswer:
    return .unanswered
  case .otherDeviceAnswered:
    return .answeredElsewhere
  // This mapping is not really correct, as .inactive is triggered by the local peer.
  case .inactive:
    return .remoteEnded
  default:
    break
  }
  return .failed
}

