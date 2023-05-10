//
//  ContentView.swift
//  CallFriendProject
//
//  Created by оля on 06.04.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var contentViewModel: ContentViewModel
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        VStack{
            switch contentViewModel.state{
            case .login: AuthView(viewModel: AuthViewModel(callMediator: contentViewModel.callMeadiator))
            case .main:
                MainView(viewModel: MainViewModel(callMeaditor: contentViewModel.callMeadiator))
            case .call:
                CallView(viewModel: CallViewModel(callMediator: contentViewModel.callMeadiator))
            case .preview:
                SplashView()
            }
        }.onChange(of: scenePhase){ phase in
            if phase == .active && contentViewModel.callMeadiator.call != nil {
                contentViewModel.state = .call

            }
        }
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
