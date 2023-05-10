//
//  CallView.swift
//  CallFriendProject
//
//  Created by оля on 01.05.2022.
//

import SwiftUI

struct CallView: View {
    
    @ObservedObject var viewModel: CallViewModel
    
    var body: some View {
        switch viewModel.call?.state{
        case .initiating:
            if viewModel.call!.direction == .outgoing {
                OutgoingCallView(haungUpAction: viewModel.hangUpCall, callee: viewModel.call?.destination ?? "")
            }else {
                IncommingCallView(acceptCallAction: viewModel.acceptCall, hungUpAction: viewModel.hangUpCall, caller: viewModel.getUsername() , speaker: viewModel.call?.destination ?? "" )
            }
        case .started:
            if viewModel.call!.callType == .video{
                VideoView(client: viewModel.callMediator.client!, destination: self.viewModel.call?.destination ?? "", hangUpAction: viewModel.hangUpCall)
            } else {
                SpeakingView(speaker: viewModel.call?.destination ?? "", hangUpAction: viewModel.hangUpCall)
            }
        case .ended:
            EmptyView()
        case .none: EmptyView()
        }
    }
}

