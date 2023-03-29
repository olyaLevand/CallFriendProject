//
//  LoginView.swift
//  CallFriendProject
//
//  Created by оля on 10.04.2022.
//

import SwiftUI

struct LoginView: View {
    var viewModel: LoginViewModel

    @State var username: String = ""

    var body: some View {
        Spacer()
        Text("Log In")
        Spacer()
        TextField(
            "Enter username: ",
            text: $username
        )
            .frame(width: 200)
        Spacer()
        Button(action: {
             viewModel.login(username: username)
        }, label: {
            Text("Tap to login")
                .foregroundColor(Color.blue)
        })
        Spacer()
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
