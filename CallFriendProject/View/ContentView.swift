//
//  ContentView.swift
//  CallFriendProject
//
//  Created by оля on 06.04.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var contentViewModel = ContentViewModel()
    
    var body: some View {
        switch contentViewModel.state{
        case .login: LoginView(viewModel: contentViewModel.loginViewModel)
        case .main:
            MainView(viewModel:contentViewModel.mainViewModel, username: contentViewModel.dataCollector.userName!)
        }
 
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
