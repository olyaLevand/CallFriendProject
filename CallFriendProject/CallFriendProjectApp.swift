//
//  CallFriendProjectApp.swift
//  CallFriendProject
//
//  Created by оля on 06.04.2022.
//

import SwiftUI

@main
struct CallFriendProjectApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            ContentView(contentViewModel: ContentViewModel(callMeadiator: appDelegate.callKitMediator))
        }
        
    }
}
