//
//  ActiveUsersView.swift
//  CallFriendProject
//
//  Created by Olya Levandivska on 08.05.2023.
//

import SwiftUI

struct ActiveUsersView: View {
    @Binding var activeUsers: [String]
    
    @State private var searchText = ""
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Online users")
                .foregroundColor(AppColors.darkBlueColor)
                .font(.title)
                .padding()
            
            NavigationStack{
                VStack{
                    List{
                        ForEach(activeUsers, id: \.self) {item in
                                Text("\(item)")
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(AppColors.darkBlueColor)
                                    .font(.headline)
                        }
                    }
                }
            }.searchable(text: $searchText)
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .padding(.top, 80)
    }
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return activeUsers
        } else {
            return activeUsers.filter { $0.contains(searchText) }
        }
    }
}

//struct ActiveUsersView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActiveUsersView()
//    }
//}
