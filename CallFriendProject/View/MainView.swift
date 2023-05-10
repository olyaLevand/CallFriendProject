//
//  MainView.swift
//  CallFriendProject
//
//  Created by оля on 10.04.2022.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    @State var calleeName: String = ""
    @State var option: ConnectOption = .normalCall
    @State var presentAlert: Bool = false
    @State var activeUsers: [String] = []
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30){
                HStack{
                    Spacer()
                    VStack(alignment: .trailing, spacing: 10){
                        Button("Log out"){
                            viewModel.logout()
                        }    .padding(.horizontal)
                            .padding(.vertical, 10)
                            .foregroundColor(.white)
                            .background(AppColors.darkBlueColor)
                            .cornerRadius(10)
                            .font(.headline)
                            .cornerRadius(15)
                            VStack{
                                NavigationLink{
                                    ActiveUsersView(activeUsers: $activeUsers)
                                        .onAppear{
                                            viewModel.getActiveUsers(completion: {users in
                                                self.activeUsers = users
                                            })
                                        }
                                } label: {
                                    Text("Online users")
                                        .padding(.horizontal)
                                        .padding(.vertical, 10)
                                        .foregroundColor(.white)
                                        .background(AppColors.grayColor)
                                        .cornerRadius(10)
                                        .font(.headline)
                                        .cornerRadius(15)
                                }
                            }
                    }.padding()
                }.padding(.bottom, 100)
                Text("Hello, \(viewModel.getUsername())")
                    .foregroundColor(AppColors.darkBlueColor)
                    .font(.largeTitle)
                    .padding()
                    .padding(.bottom, 30)
                
                VStack(alignment: .leading, spacing: 0){
                    Text("Enter callee username")
                        .foregroundColor(AppColors.darkBlueColor)
                        .font(.headline)
                        .padding(.vertical, 5)
                    TextField(
                        " Username ",
                        text: $calleeName
                    )
                    .frame(width: UIScreen.main.bounds.width*0.6)
                        .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(AppColors.darkBlueColor, lineWidth: 2)
                            )
                            .foregroundColor(AppColors.darkBlueColor)
                }
                
                HStack{
                    Text("Call type: ")
                        .foregroundColor(AppColors.darkBlueColor)
                        .font(.headline)
                    Picker("Call type", selection: $option) {
                        Text("Voice").tag(ConnectOption.normalCall)
                        Text("Video").tag(ConnectOption.videoCall)
                    }
                    .pickerStyle(.segmented)
                    .background(AppColors.darkBlueColor)
                    .cornerRadius(5)
                    .onReceive([self.option].publisher.first()) { (value) in
                        value == .normalCall ? viewModel.setCallType(.voice) : viewModel.setCallType(.video)
                    }
                }.padding(.horizontal, 70)
                
                Button("Connect"){
                    if calleeName.isEmpty {
                        presentAlert = true
                    } else {
                        viewModel.connectButtonTapped(calleeName: calleeName)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .foregroundColor(.white)
                .background(AppColors.darkBlueColor)
                .cornerRadius(10)
                .padding()
                .font(.headline)
                .cornerRadius(15)
                Spacer()
        }
            .alert("Please, enter callee nickname", isPresented: $presentAlert) {
                        Button("OK", role: .cancel) {
                            presentAlert = false
                        }
                    }
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}


extension MainView{
    enum ConnectOption{
        case normalCall
        case videoCall
    }
}
