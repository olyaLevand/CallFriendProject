//
//  SignInView.swift
//  CallFriendProject
//
//  Created by Olya Levandivska on 05.05.2023.
//

import SwiftUI

struct SignUpView: View {
    
    var action: () -> ()
    var swichAction: () -> ()
    @Binding var username: String
    @Binding var password: String
    @Binding var email: String

    @State var showAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .center){
            Text("Sing Up")
                .foregroundColor(AppColors.darkBlueColor)
                .font(.largeTitle)
                .padding(50)
                .padding(.bottom, 100)
            TextField(
                " Email ",
                text: $email
            )
            .frame(width: UIScreen.main.bounds.width*0.6)
            .padding(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(AppColors.darkBlueColor, lineWidth: 2)
                )
                .foregroundColor(AppColors.darkBlueColor)
            
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
                if username.isEmpty || email.isEmpty || password.isEmpty{
                    showAlert = true
                } else {
                    action()
                }
            }, label: {
                Text("Sign up")
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
                Text("Already have a account? Click to sign in")
                    .multilineTextAlignment(.center)
                    .foregroundColor(AppColors.darkBlueColor)
                    .font(.headline)
                    .padding(40)
            })
            
        }.alert("Please, enter all cedentials", isPresented: $showAlert) {
                    Button("OK", role: .cancel) {
                        showAlert = false
                    }
                }
        .padding(0)
    }
}

//struct SignInView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInView()
//    }
//}
