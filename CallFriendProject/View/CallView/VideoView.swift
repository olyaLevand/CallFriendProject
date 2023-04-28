////
////  ContentView.swift
////  Agora-iOS-Tutorial-SwiftUI-1to1
////
////  Created by GongYuhua on 2019/6/17.
////  Copyright © 2019 Agora. All rights reserved.
////
//


import SwiftUI
import UIKit
import SinchRTC

struct VideoView : View {
    @State var client: SinchClient
    @State var destination: String
    var hangUpAction : () -> ()
    
    var body: some View {
        VStack{
            Text(destination)
                .multilineTextAlignment(.center)
                .foregroundColor(AppColors.darkBlueColor)
                .font(.largeTitle)
                .padding(20)
                .padding(.bottom, 30)
            
            VideoSwiftUIView(client: client)
            
            Button(action: {
                hangUpAction()
            }, label: {
                Text("Hung Up")
                    .padding(15)
                    .background(AppColors.grayColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
        }
    }
}
