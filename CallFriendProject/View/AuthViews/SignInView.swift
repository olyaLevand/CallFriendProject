//
//  LoginView.swift
//  CallFriendProject
//
//  Created by оля on 10.04.2022.
//

import SwiftUI
import AlertToast
import Combine

struct SignInView: View {
    
    enum ViewState{
        case login
        case signin
    }
    
    var action: () -> ()
    var swichAction: () -> ()
    @Binding var username: String
    @Binding var password: String
    @State var passwordAlert: Bool = false
    @State var usernameAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .center){
            Text("Sign In")
                .foregroundColor(AppColors.darkBlueColor)
                .font(.largeTitle)
                .padding(50)
                .padding(.bottom, 100)
//            Text("Hi! Welcome to the CallFriend application!")
//                .multilineTextAlignment(.center)
//                .foregroundColor(AppColors.darkBlueColor)
//                .font(.headline)
//                .padding(40)

            
            TextField(
                " Username ",
                text: $username
            )
            .frame(width: UIScreen.main.bounds.width*0.6)
            .padding(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(AppColors.darkBlueColor, lineWidth: 2)
                )
                .foregroundColor(AppColors.darkBlueColor)
            
            TextField(
                " Password ",
                text: $password
            )
            .frame(width: UIScreen.main.bounds.width*0.6)
            .padding(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(AppColors.darkBlueColor, lineWidth: 2)
                )
                .foregroundColor(AppColors.darkBlueColor)
            
            
            Button(action: {
                if username.isEmpty {
                    usernameAlert = true
                } else if password.isEmpty{
                    passwordAlert = true
                }else {
                    action()
                }
            }, label: {
                Text("Sign in")
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
            Button(action: {swichAction()}, label: {
                Text("Don't have a account? Click to Sign Up")
//                    .padding(.horizontal)
//                    .padding(.vertical, 10)
//                    .foregroundColor(.white)
//                    .background(AppColors.darkBlueColor)
//                    .cornerRadius(10)
//                    .padding()
//                    .font(.headline)
//                    .cornerRadius(15)
                    .multilineTextAlignment(.center)
                    .foregroundColor(AppColors.darkBlueColor)
                    .font(.headline)
                    .padding(50)
            })
            

            
        }.alert("Please, enter username", isPresented: $usernameAlert) {
                    Button("OK", role: .cancel) {
                        usernameAlert = false
                    }
                }
        
        .alert("Please, enter password", isPresented: $passwordAlert) {
                    Button("OK", role: .cancel) {
                        passwordAlert = false
                    }
                }
        .padding(0)
    }
}


//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(presenter: LoginViewPresenter(callMediator: CallMediator(delegate: CallMediatorD)))
//    }
//}
