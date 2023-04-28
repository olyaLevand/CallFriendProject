//
//  CallView.swift
//  CallFriendProject
//
//  Created by оля on 01.05.2022.
//

import SwiftUI

struct CallView: View {
    
    @ObservedObject var presenter: CallViewPresenter
    
    var body: some View {
        switch presenter.call?.state{
        case .initiating:
            if presenter.call!.direction == .outgoing {
                OutgoingCallView(haungUpAction: presenter.hangUpCall, callee: presenter.call?.destination ?? "")
            }else {
                IncommingCallView(acceptCallAction: presenter.acceptCall, hungUpAction: presenter.hangUpCall, caller: presenter.getUsername() , speaker: presenter.call?.destination ?? "" )
            }
        case .started:
            if presenter.call!.callType == .video{
                VideoView(client: presenter.callMediator.client!, destination: self.presenter.call?.destination ?? "", hangUpAction: presenter.hangUpCall)
            } else {
                SpeakingView(speaker: presenter.call?.destination ?? "", hangUpAction: presenter.hangUpCall)
            }
        case .ended:
            EmptyView()
        case .none: EmptyView()
        }
    }
}

