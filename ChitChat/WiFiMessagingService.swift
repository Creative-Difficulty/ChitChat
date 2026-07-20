//
//  Temp.swift
//  ChitChat
//
//  Created by Alexander Leschanz on 17.07.26.
//

import SwiftUI
import Network
import Combine

// Requires:
//   NSLocalNetworkUsageDescription = "Finds nearby devices to chat with"
//   NSBonjourServices = ["_minichat._tcp"]

final class WiFiMessageProtocol: ObservableObject {
    @Published var log: [String] = []

    private let queue = DispatchQueue(label: "chitchat")
    private var listener: NWListener?
    private var browser: NWBrowser?
    private var connections: [NWConnection] = []
    private var thisDevicesUUID = UUID().uuidString;

    private var params: NWParameters {
        let tcp = NWParameters.tcp
        tcp.includePeerToPeer = true
        return tcp
    }

    func start() {
        // Advertise ourselves
        listener = try? NWListener(using: params)
        listener?.service = .init(name: thisDevicesUUID, type: "_chitchat._tcp")
        listener?.newConnectionHandler = { [weak self] in self?.choose_connection(c: $0) }
        listener?.start(queue: queue)

        // Find others
        browser = NWBrowser(for: .bonjour(type:  "_chitchat._tcp", domain: nil), using: params)
        browser?.browseResultsChangedHandler = { [weak self] results, _ in
            guard let self else { return }
            for r in results {
                if case let .service(name, _, _, _) = r.endpoint, name == self.thisDevicesUUID { continue }
                self.choose_connection(c: NWConnection(to: r.endpoint, using: self.params))
            }
        }
        
        browser?.start(queue: queue)
        log_event("started — looking for peers…")
    }

    func send(text: String) {
        queue.async {
            let data = Data((text + "\n").utf8)
            for c in self.connections where c.state == .ready {
                c.send(content: data, completion: .contentProcessed { _ in })
            }
        }
        log_event("me: \(text)")
    }

    private func choose_connection(c: NWConnection) {
        queue.async {
            guard !self.connections.contains(where: { $0 === c }) else { return }
            self.connections.append(c)
            c.stateUpdateHandler = { [weak self] state in
                if case .ready = state {
                    let iface = c.currentPath?.availableInterfaces.first?.name ?? "?"
                    self?.log_event("connected via \(iface)")   // awdl0 = direct, en0 = WiFi network
                    self?.runMessaegRecieveLoop(conn: c)
                }
                if case .failed = state {
                    self?.queue.async { self?.connections.removeAll { $0 === c } }
                }
            }
            c.start(queue: self.queue)
        }
    }

    private func runMessaegRecieveLoop(conn: NWConnection) {
        conn.receive(minimumIncompleteLength: 1, maximumLength: 65536) { [weak self] data, _, done, err in
            if let data, let text = String(data: data, encoding: .utf8) {
                self?.log_event("peer: \(text)")
            }
            if err == nil && !done { self?.runMessaegRecieveLoop(conn: conn) }
        }
    }

    private func log_event(_ line: String) {
        DispatchQueue.main.async { self.log.append(line) }
    }
}
