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
    var speakers: [String]? = nil
    
    var body: some View {
        VStack{
            Text("Call from \(caller)")
            
            HStack{
                Button(action: { acceptCallAction() }, label: { Text("Accept")
                        .background(Color.green)
                        .padding()
                }
                )
                Spacer()
                
                Button(action: {hungUpAction() }, label: {Text("Hang up")
                        .background(Color.red)
                        .padding()
                            }
                    )
                }
        }
    }
}

//struct IncommingCallView_Previews: PreviewProvider {
//    static var previews: some View {
//        IncommingCallView()
//    }
//}
