//
//  ActiveUsersView.swift
//  CallFriendProject
//
//  Created by Olya Levandivska on 08.05.2023.
//

import SwiftUI

struct ActiveUsersView: View {
    @Binding var activeUsers: [String]
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Online users")
                .foregroundColor(AppColors.darkBlueColor)
                .font(.title)
                .padding()
            List{
                ForEach(activeUsers, id: \.self) {item in
                        Text("\(item)")
                            .multilineTextAlignment(.center)
                            .foregroundColor(AppColors.darkBlueColor)
                            .font(.headline)
                }
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .padding(.top, 80)
    }
}

//struct ActiveUsersView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActiveUsersView()
//    }
//}
