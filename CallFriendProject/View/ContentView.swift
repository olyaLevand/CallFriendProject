//
//  ContentView.swift
//  CallFriendProject
//
//  Created by оля on 06.04.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var contentViewPresenter: ContentViewPresenter
    
    var body: some View {
        switch contentViewPresenter.state{
        case .login: LoginView(presenter: LoginViewPresenter(callMediator: contentViewPresenter.callMeadiator))
        case .main:
            MainView(presenter: MainViewPresenter(callMeaditor: contentViewPresenter.callMeadiator))
        case .call:
            CallView(presenter: CallViewPresenter(callMediator: contentViewPresenter.callMeadiator))
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
