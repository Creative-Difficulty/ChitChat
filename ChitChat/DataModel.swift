//
//  Structs.swift
//  ChitChat
//
//  Created by Alexander Leschanz on 26.07.26.
//

import Foundation
import SwiftData

typealias PublicKeyString = String

struct Contact {
    let userPublicKey: PublicKeyString
    
    // E.g. "Jane Appleseed"
    // (First, Last)
    // TODO: dedup this with user handles? or some other way that's visible to the user and not changeable by the other contacts
    let displayName: String
    
    // Users can enable a notification to display nearby online users who may be chatting with other users and discover them to start chatting, hence the `trusted` field
    let isKnown: Bool
    let isNear: Bool
}

@Model
final class Message: Identifiable, Equatable {
    @Attribute(.unique) var id = UUID()
    
    var content: String
    var sentByPubKey: PublicKeyString
    
    init(text: String, sentByPubKey: PublicKeyString) {
        self.content = text
        self.sentByPubKey = sentByPubKey
    }
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
    
    // Completely disconnected from everything
    case disabled
}

