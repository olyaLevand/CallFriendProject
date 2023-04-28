//
//  LoginView.swift
//  CallFriendProject
//
//  Created by оля on 10.04.2022.
//

import SwiftUI
import AlertToast

struct LoginView: View {
    var presenter: LoginViewPresenter

    @State var username: String = ""
    @State var presentAlert: Bool = false

    var body: some View {
        VStack(alignment: .center){
            Text("Log In")
                .foregroundColor(AppColors.darkBlueColor)
                .font(.largeTitle)
                .padding(50)
                .padding(.bottom, 100)
            Text("Hi! Welcome to the CallFriend application, here you can make a call to your friends!")
                .multilineTextAlignment(.center)
                .foregroundColor(AppColors.darkBlueColor)
                .font(.headline)
                .padding(40)

            TextField(
                " Enter username ",
                text: $username
            )
            .frame(width: UIScreen.main.bounds.width*0.6)
            .padding(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(AppColors.darkBlueColor, lineWidth: 2)
                )
                .foregroundColor(AppColors.darkBlueColor)
            
            Button(action: {
                if username.isEmpty{
                    presentAlert = true
                } else {
                    presenter.loginButtonTap(username: username)
                }
            }, label: {
                Text("Log in")
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .foregroundColor(.white)
                    .background(AppColors.darkBlueColor)
                    .cornerRadius(10)
                    .padding()
                    .font(.headline)
                    .cornerRadius(15)
            })
            Spacer()
            
        }.alert("Please, enter username", isPresented: $presentAlert) {
                    Button("OK", role: .cancel) {
                        presentAlert = false
                    }
                }
        .padding(0)
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
