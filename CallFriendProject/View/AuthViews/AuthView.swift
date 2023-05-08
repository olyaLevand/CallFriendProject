//
//  AuthView.swift
//  CallFriendProject
//
//  Created by Olya Levandivska on 05.05.2023.
//

import Foundation
import SwiftUI


struct AuthView: View {
    enum ViewState{
        case login
        case signin
    }
    
    @ObservedObject var presenter: LoginViewPresenter

    @State var viewState: ViewState = .login
    @State var username: String = ""
    @State var password: String = ""
    @State var email: String = ""
    
    @State var showError = false
    @State var errorMessage: String = ""
    
    var body: some View {
        VStack{
            switch viewState{
            case .login: SignInView(action: signin, swichAction: switchAction, username: $username, password: $password)
            case .signin: SignUpView(action: signup, swichAction: switchAction, username: $username, password: $password, email: $email)
            }
        }.alert(errorMessage, isPresented: $showError) {
            Button("OK", role: .cancel) {
                showError = false
            }
        }
    }
    
    func signin(){
        presenter.signIn(email: username, password: password, completionWithError: { error in
            self.errorMessage = error
            self.showError = true
        })
    }
    
    func signup(){
        presenter.signUp(email: email, password: password, username: username, completionWithError: { error in
            self.errorMessage = error
            self.showError = true
        })
    }
    
    func switchAction(){
        if viewState == .login{
            viewState = .signin
            username = ""
            password = ""
        } else if viewState == .signin{
            viewState = .login
            username = ""
            password = ""
        }
    }
}

//struct SignInView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInView()
//    }
//}
