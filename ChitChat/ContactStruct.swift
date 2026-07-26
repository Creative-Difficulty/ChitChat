//
//  ContactStruct.swift
//  ChitChat
//
//  Created by Alexander Leschanz on 26.07.26.
//

import Foundation

struct Contact {
    // TODO: Impl, also can we somehow bake the username into each user's key to deduplicate without using a central server?
    // Generated key with a username handle baked in?
    let userPublicKey: String?
    
    // E.g. "Jane Appleseed"
    // (First, Last)
    // TODO: dedup this with user handles? or some other way that's visible to the user and not changeable by the other contacts
    let displayName: String
    
    // Users can enable a notification to display nearby online users who may be chatting with other users and discover them to start chatting, hence the `trusted` field
    let trusted: Bool
    let isNear: Bool
}

// ------------------

enum NetworkStates {
    // This is for WiFi
    case online
    case offline
    
    // Interesting thing for the user, should be the same as online and offline for impl
    case awdl
    
    // Fallback
    case bluetooth
    
    
    case disabled
}
