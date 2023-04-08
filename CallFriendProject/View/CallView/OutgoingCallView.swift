//
//  OutgoingCallView.swift
//  CallFriendProject
//
//  Created by оля on 01.05.2022.
//

import SwiftUI

struct OutgoingCallView: View {
    
    var haungUpAction: () -> ()
    var callee: String
    
    var body: some View {
        VStack{
            Text("Calling to \(callee)")
                .foregroundColor(AppColors.yellowColor)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .padding(20)
                .padding(.bottom, 30)
            
            Button(action: {
                haungUpAction()
            }, label: {
                Text("Cancel")
                    .padding(15)
                    .background(AppColors.darkBlueColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(AppColors.grayColor)

    }
}

struct OutgoingCallView_Previews: PreviewProvider {
    static var previews: some View {
        OutgoingCallView(haungUpAction: {
            
        }, callee: "Olya")
    }
}
