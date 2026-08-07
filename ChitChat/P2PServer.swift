//
//  P2PServer.swift
//  ChitChat
//
//  Created by Alexander Leschanz on 07.08.26.
//

import Network

let params: NWParameters = {
    let p = NWParameters.tcp
    p.includePeerToPeer = true
    return p
}()

let queue = DispatchQueue(label: "p2p")
var listener: NWListener?
var browser: NWBrowser?

public func start() {
    listener = try! NWListener(using: params)
    listener?.service = NWListener.Service(name: "alice", type: "_chitchat._tcp")
    listener?.start(queue: queue)

    browser = NWBrowser(for: .bonjour(type: "_chitchat._tcp", domain: nil), using: params)
    browser?.browseResultsChangedHandler = { results, _ in
        for r in results { print(r.endpoint) }
    }
    browser?.start(queue: queue)
}
