//
//  MainView.swift
//  CallFriendProject
//
//  Created by оля on 10.04.2022.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var presenter: MainViewPresenter
    
    @State var calleeName: String = ""
    @State var option: ConnectOption = .normalCall
    @State var presentAlert: Bool = false
    
    var body: some View {
            VStack(spacing: 30){
                HStack{
                    Spacer()
                    Button("Logout"){
                        presenter.logout()
                    }    .padding(.horizontal)
                        .padding(.vertical, 10)
                        .foregroundColor(.white)
                        .background(AppColors.darkBlueColor)
                        .cornerRadius(10)
                        .padding()
                        .font(.headline)
                        .cornerRadius(15)
                }
                
                Spacer()
                
                Text("Hello, \(presenter.getUsername())")
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
                        value == .normalCall ? presenter.setCallType(.voice) : presenter.setCallType(.video)
                    }
                }.padding(.horizontal, 70)
                
                Button("Connect"){
                    if calleeName.isEmpty {
                        presentAlert = true
                    } else {
                        presenter.connectButtonTapped(calleeName: calleeName)
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
