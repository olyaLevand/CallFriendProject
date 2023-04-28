//
//  AppDelegate.swift
//  CallFriendProject
//
//  Created by Olya Levandivska on 09.04.2023.
//

import Foundation
import UIKit
import SinchRTC
import OSLog
import PushToTalk

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    var window: UIWindow?
    private var push: SinchManagedPush!
    var callKitMediator: CallMediator!
    
    
    private func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            // 1. Check to see if permission is granted
            guard granted else { return }
            // 2. Attempt registration for remote notifications on the main thread
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
      // If there is one established or initiating call, show the callView of the
      // current call when the App is brought to foreground. This is mainly to handle
      // the UI transition when clicking the App icon on the lockscreen CallKit UI,
      // and the UI transition when an incoming call is answered from homescreen CallKit UI.
        self.trancitionToCallView()
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      SinchRTC.setLogCallback { (severity: SinchRTC.LogSeverity, area: String, msg: String, _: Date) in
          os_log("%{public}@", log: OSLog(subsystem: "com.sinch.sdk.app", category: area), type: .default , msg)
      }

      self.push = SinchRTC.managedPush(forAPSEnvironment: SinchRTC.APSEnvironment.development)
      self.push.delegate = self
      self.push.setDesiredPushType(SinchManagedPush.TypeVoIP)        
      self.callKitMediator = CallMediator(delegate: self)
      registerForPushNotifications()
        
        if let username = UserDefaults.standard.string(forKey: UserSettingKey.name){
            self.callKitMediator.createClient(withUserId: username, andCallback: {error in
                if error == nil {
                    DispatchQueue.main.async {
                        AppRouter.goToMainScreen()
                    }
                }
            })
        }
      return true
    }
    
    func handlePushNotification(withInfo info: [AnyHashable: Any]) {
      if let client = self.callKitMediator.client {
        client.relayPushNotification(withUserInfo: info)
      }
    }
    
    func trancitionToCallView(){
        AppRouter.goTpCallScreen()
    }
}

extension AppDelegate: CallKitMediatorDelegate {
  func handleIncomingCall(_ call: SinchCall) {
      self.trancitionToCallView()
  }
}

extension AppDelegate: SinchManagedPushDelegate {
  func managedPush(_ managedPush: SinchManagedPush,
                   didReceiveIncomingPushWithPayload payload: [AnyHashable: Any], for type: String) {
    print("didReceiveIncomingPushWithPayload: %{public}@")

    // Since iOS 13 the application must report an incoming call to CallKit if a VoIP push notification was used, and
    // this must be done within the same run loop as the push is received (i.e. GCD async dispatch must not be used). See
    // https://developer.apple.com/documentation/pushkit/pkpushregistrydelegate/2875784-pushregistry for details.
    self.callKitMediator.reportIncomingCall(withPushPayload: payload, withCompletion: { err in

      // It has to be the same GCD queue as PKPushKit deliver notification on
      // (as we must report to CallKit within the same runloop, see above),
      // so this dispatch to main queue is here because we also want customer to only interact with SinchClient
      // on a single thread (we make no guarantees that SinchClient is thread safe).
      DispatchQueue.main.async {
        self.handlePushNotification(withInfo: payload)
      }

//      if err != nil {
//        os_log("Error when reportintg call to CallKit: %{public}@",
//               log: self.customLog, type: .error, err!.localizedDescription)
//      }
    })
  }
}
