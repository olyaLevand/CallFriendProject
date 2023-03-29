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
            if call!.direction == .outgoing{
                OutgoingCallView(haungUpAction: hangUpAction , callees: call!.allCallees)
            }else {
                IncommingCallView(acceptCallAction: acceptCallAction, hungUpAction: hangUpAction, caller: call!.caller)
            }
        case .started:
            if call!.callType == .video{
                VideoView(channelId: call!.chanelId!)
            } else {
                SpeakingView(speakers: call!.allCallees, hangUpAction: hangUpAction)
            }
        case .ended: EmptyView()
        case .none: EmptyView()
        }
    }
}

