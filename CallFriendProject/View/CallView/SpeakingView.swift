//
//  SpeakingView.swift
//  CallFriendProject
//
//  Created by оля on 01.05.2022.
//

import SwiftUI

struct SpeakingView: View {
    var speaker: String
    var hangUpAction: () -> ()
    
    var body: some View {
        VStack{
            Text("\(speaker)")
                .multilineTextAlignment(.center)
                .foregroundColor(AppColors.darkBlueColor)
                .font(.largeTitle)
                .padding(20)
                .padding(.bottom, 30)
            
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
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(AppColors.yellowColor)
    }

}

struct SpeakingView_Previews: PreviewProvider {
    static var previews: some View {
        SpeakingView(speaker: "Marry", hangUpAction: {
            
        })
    }
}
