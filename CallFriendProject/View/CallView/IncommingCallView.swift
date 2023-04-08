//
//  IncommingCallView.swift
//  CallFriendProject
//
//  Created by оля on 01.05.2022.
//

import SwiftUI

struct IncommingCallView: View {
    var acceptCallAction: () -> ()
    var hungUpAction: () -> ()
    var caller: String
    var speaker: String
    
    var body: some View {
        VStack{
            Text("Call from \(caller)")
                .foregroundColor(AppColors.yellowColor)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .padding(20)
                .padding(.bottom, 30)
            
            HStack(spacing: 100){
                Button(action: { acceptCallAction() }, label: { Text("Accept")
                        .padding(15)
                        .background(AppColors.yellowColor)
                        .foregroundColor(AppColors.darkBlueColor)
                        .cornerRadius(10)
                }
                )
                
                Button(action: {hungUpAction() }, label: {Text("Hang up")
                        .padding(15)
                        .background(AppColors.grayColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                            }
                    )
            }.padding()
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
         .background(AppColors.darkBlueColor)
    }
}

struct IncommingCallView_Previews: PreviewProvider {
    static var previews: some View {
        IncommingCallView(acceptCallAction: {}, hungUpAction: {}, caller: "Olya", speaker: "Marry")
    }
}
