//
//  CallView.swift
//  CallFriendProject
//
//  Created by оля on 01.05.2022.
//

import SwiftUI

struct CallView: View {
    
    @Binding var call: Call?
    
    var hangUpAction: () -> ()
    var acceptCallAction: () -> ()
    
    var body: some View {
        switch call?.state{
        case .initiating:
            if call!.direction == .outgoing {
                OutgoingCallView(haungUpAction: hangUpAction, callee: "Olya")
            }else {
                IncommingCallView(acceptCallAction: acceptCallAction, hungUpAction: hangUpAction, caller: call!.caller, speaker: "Olya")
            }
        case .started:
            if call!.callType == .video{
                VideoView(channelId: call!.chanelId!)
            } else {
                SpeakingView(speaker: "M", hangUpAction: hangUpAction)
            }
        case .ended: EmptyView()
        case .none: EmptyView()
        }
    }
}

