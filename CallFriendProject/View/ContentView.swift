//
//  ContentView.swift
//  CallFriendProject
//
//  Created by оля on 06.04.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var contentViewPresenter: ContentViewPresenter
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        VStack{
            switch contentViewPresenter.state{
            case .login: AuthView(presenter: AuthViewPresenter(callMediator: contentViewPresenter.callMeadiator))
            case .main:
                MainView(presenter: MainViewPresenter(callMeaditor: contentViewPresenter.callMeadiator))
            case .call:
                CallView(presenter: CallViewPresenter(callMediator: contentViewPresenter.callMeadiator))
            case .preview:
                SplashView()
            }
        }.onChange(of: scenePhase){ phase in
            if phase == .active && contentViewPresenter.callMeadiator.call != nil {
                contentViewPresenter.state = .call

            }
        }
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
