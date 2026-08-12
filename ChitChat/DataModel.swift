//
//  DataModel.swift
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
    let displayName: String
    
    // Users can enable the display of nearby online users who may be chatting with other users and discover them to start chatting, hence the `isKnown` field
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
    // WiFi
    case wifi
    
    // Interesting distinction for the user, the same as wifi for impl
    case awdl
    
    // Fallback
    case bluetooth
    
    // Completely disconnected from everything
    case disabled
}
