//
//  SpeakingView.swift
//  CallFriendProject
//
//  Created by оля on 01.05.2022.
//

import SwiftUI

struct SpeakingView: View {
    var speakers: [String]
    var hangUpAction: () -> ()
    
    var body: some View {
        VStack{
            Text("Conversation with: \(speakers.joined(separator: ", "))")
            
            Button(action: {
                hangUpAction()
            }, label: {
                Text("Hung Up")
            })
        }

        
        
    }
}

//struct SpeakingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SpeakingView(speakers: ["Marry", "Mykola", "Taras"])
//    }
//}
