//
//  OutgoingCallView.swift
//  CallFriendProject
//
//  Created by оля on 01.05.2022.
//

import SwiftUI

struct OutgoingCallView: View {
    
    var haungUpAction: () -> ()
    var callees: [String]
    
    var body: some View {
        VStack{
            Text("Calling to \(callees.joined(separator: ", "))")
            
            Button(action: {
                haungUpAction()
            }, label: {
                Text("HungUp")
            })
        }
    }
}

//struct OutgoingCallView_Previews: PreviewProvider {
//    static var previews: some View {
//        OutgoingCallView(callees: ["Olya", "Marry"])
//    }
//}
