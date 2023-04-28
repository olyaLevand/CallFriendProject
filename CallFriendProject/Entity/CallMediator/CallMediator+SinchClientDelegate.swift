//
//  CallMediator+SinchClientDelegate.swift
//  CallFriendProject
//
//  Created by Olya Levandivska on 08.04.2023.
//

import Foundation

import SinchRTC

extension CallMediator: SinchClientDelegate {
    func clientDidStart(_ client: SinchRTC.SinchClient) {
        print("clientDidStart")
    }
    
    func clientDidFail(_ client: SinchRTC.SinchClient, error: Error) {
        print("clientDidFail")
    }
    
    func clientRequiresRegistrationCredentials(_ client: SinchClient, withCallback callback: SinchClientRegistration) {
      // WARNING: Embedding the Application Secret and use of the class SINJWT as shown here
      // should NOT be done for an application deployed to production.
      // The class SINJWT is only here to show how to construct and sign a registration token.

      do {
        let jwt = try sinchJWTForUserRegistration(withApplicationKey: APPLICATION_KEY,
                                                  applicationSecret: APPLICATION_SECRET,
                                                  userId: client.userId)
        callback.register(withJWT: jwt)

      } catch {
        callback.registerDidFail(error: error)
      }
    }
    
}
