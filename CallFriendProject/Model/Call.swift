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
    
    enum CallType: String{
        case normal = "normal"
        case group = "group"
        case video = "video"
    }
    
    var state: State
    var direction: Direction
    var caller: String
    var allCallees: [String]
    var callType: CallType
    var chanelId: String?
    
    init(state: State, direction: Direction, callType: CallType, caller: String, callees: [String], channelId: String? = nil){
        self.state = state
        self.direction = direction
        self.caller = caller
        self.allCallees = callees
        self.callType = callType
        self.chanelId = channelId
    }
}
