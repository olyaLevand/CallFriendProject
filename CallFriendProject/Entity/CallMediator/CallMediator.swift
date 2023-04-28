//
//  CallMediator.swift
//  CallFriendProject
//
//  Created by Olya Levandivska on 08.04.2023.
//

import Foundation
import SinchRTC
import CallKit
import OSLog
import UIKit
import Combine


protocol CallKitMediatorDelegate: AnyObject {
  func handleIncomingCall(_ call: SinchCall)
}


protocol CallKitMediatorObserver: SinchCallDelegate {}

final class CallMediator: NSObject, ObservableObject {
    
    typealias CreateCallback = (_ error: Error?) -> Void
    var createCallback: CreateCallback!
    
    static let userIDKey: String = "com.sinch.userId"
    let customLog = OSLog(subsystem: "com.sinch.sdk.app", category: "CallKitMediator")

    var client: SinchClient?
    weak var delegate: CallKitMediatorDelegate!
    var provider: CXProvider!
    var callController: CXCallController!
    @Published var call: Call? = nil
    var sinchCall: SinchCall!

    var callType: CallType = .voice
    
    init(delegate: CallKitMediatorDelegate) {
      super.init()
      self.delegate = delegate
      let config = CXProviderConfiguration(localizedName: "Sinch")
      config.maximumCallGroups = 1
      config.maximumCallsPerCallGroup = 1
      config.supportedHandleTypes = [.generic]
      config.supportsVideo = true
      config.ringtoneSound = "incoming.wav"

      self.provider = CXProvider(configuration: config)
      self.provider.setDelegate(self, queue: nil)
      self.callController = CXCallController()
    }
    
    func createClient(withUserId userId: String, andCallback callback: @escaping CreateCallback) {
//      guard self.client == nil else {
//        if self.client!.isStarted {
//          callback(nil)
//        }
//        return
//      }

        print("client userid: \(userId)")
      do {
        self.client = try SinchRTC.client(withApplicationKey: APPLICATION_KEY,
                                          environmentHost: ENVIRONMENT_HOST,
                                          userId: userId)
      } catch let error as NSError {
        callback(error)
      }

      self.client?.delegate = self
      self.client!.callClient.delegate = self
      self.client!.audioController.delegate = self

      self.client!.start()
        callback(nil)
        
    }
    
    func reportIncomingCall(withPushPayload payload: [AnyHashable: Any], withCompletion completion: @escaping (Error?) -> Void) {
      let notification = queryPushNotificationPayload(payload)

      if notification.isCall {
        let callNotification = notification.callResult

        // We use our internal callId (which is UUID using RFC-4122)
//        guard self.callRegistry.callKitUUID(forSinchId: callNotification.callId) == nil else { return }
        self.reportNewIncomingCallToCallKit(withNotification: callNotification, withCompletion: completion)
      }
    }
    
    private func reportNewIncomingCallToCallKit(withNotification notification: SinchCallNotificationResult,
                                                withCompletion completion: @escaping (Error?) -> Void) {
      let cxCallId = UUID()

      let update = CXCallUpdate()
      update.remoteHandle = CXHandle(type: .generic, value: notification.remoteUserId)
      update.hasVideo = notification.isVideoOffered

      self.provider.reportNewIncomingCall(with: cxCallId, update: update) { (error: Error?) in
        if error != nil {
          // If we get an error here from the OS, it is possibly the callee's phone has "Do
          // Not Disturb" turned on, check CXErrorCodeIncomingCallError in CXError.h
//          self.hangupCallOnError(withId: notification.callId)
        }
        completion(error)
      }
    }
    

    typealias CallStartedCallback = (Result<SinchCall, Error>) -> Void
    var callStarted: CallStartedCallback!
    
    func startOutgoingCall(to destination: String,
                           withCompletion completion: @escaping CallStartedCallback) {
        print("Destination: \(destination)")
        
        let handle = CXHandle(type: .generic, value: destination)
        let initiateCallAction = CXStartCallAction(call: UUID(), handle: handle)
        initiateCallAction.isVideo = true
        let initOutgoingCall = CXTransaction(action: initiateCallAction)

        self.callStarted = completion

        self.callController.request(initOutgoingCall, completion: { error in
          if let err = error {
            os_log("Error requesting start call transaction: %{public}@",
                   log: self.customLog, type: .error, err.localizedDescription)
            DispatchQueue.main.async {
              completion(.failure(err))
              self.callStarted = nil
            }
          }
        })
    }
    
    func hangup(){
        end(call: self.sinchCall)
    }
    
    private func end(call: SinchCall) {
        guard let uuid = self.call?.uuid else {
        return
      }

      let endCallAction = CXEndCallAction(call: uuid)
      let transaction = CXTransaction()
      transaction.addAction(endCallAction)

      self.callController.request(transaction, completion: { error in
        if let err = error {
        }
        self.callStarted = nil
      })
    }
    
    func setCallType(_ callType: CallType){
        self.callType = callType
    }
    
    
    func logout(){
        guard let client = self.client else { return }

        if client.isStarted {
          // Remove push registration from Sinch backend
          client.unregisterPushNotificationDeviceToken()
          client.terminateGracefully()
        }

        self.client = nil
    }
}
