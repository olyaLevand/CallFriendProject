//
//  Call.swift
//  CallFriendProject
//
//  Created by оля on 01.05.2022.
//

import Foundation


class Call {
    enum Direction{
        case outgoing
        case incomming
    }
    
    enum State{
        case initiating
        case started
        case ended
    }
    
    var uuid: UUID? = nil
    var state: State
    var direction: Direction
    var destination: String
    var callType: CallType
    var chanelId: String?
    
    init(state: State, direction: Direction, callType: CallType, destination: String, channelId: String? = nil){
        self.state = state
        self.direction = direction
        self.destination = destination
        self.callType = callType
        self.chanelId = channelId
    }
}

enum CallType: String{
    case voice = "voice"
    case video = "video"
}
