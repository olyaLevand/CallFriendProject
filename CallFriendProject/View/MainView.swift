//
//  MainView.swift
//  CallFriendProject
//
//  Created by оля on 10.04.2022.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    @State var username: String
    @State var calleeName: String = ""
    @State var option: ConnectOption? = nil
    
    var body: some View {
        if viewModel.call != nil && viewModel.call?.state != .ended {
            CallView(call: $viewModel.call, hangUpAction: viewModel.hangUp, acceptCallAction: viewModel.acceptCall )
        } else {
            VStack(spacing: 30){
                Text("Hello, \(username)")
                
                TextField(
                    "Enter callee username: ",
                    text: $calleeName
                )
                
                Text("Choose options: ")
                
                HStack{
                    Spacer()
                    
                    Button("Normal call"){
                        option = .normalCall
                    }
                    .frame(width: 100, height: 40)
                    .foregroundColor(option == .normalCall ? .white : .blue)
                    .background((option == .normalCall ? .blue : .white))
                    .cornerRadius(10)

                    Spacer()
                    Button("Video Call"){
                        option = .videoCall
                    }
                    .frame(width: 100, height: 40)
                    .foregroundColor(option == .videoCall ? .white : .blue)
                    .background((option == .videoCall ? .blue : .white))
                    .cornerRadius(10)

                    Spacer()
                }.frame(height: 70)
                
                Button("Tap to connect"){
                    if option == .normalCall{
                        viewModel.startCall(to: calleeName)
                    } else if option == .videoCall{
                        viewModel.startVideo(to: calleeName)
                    }
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
