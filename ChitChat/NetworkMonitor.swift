//
//  WiFiObserver.swift
//  ChitChat
//
//  Created by Alexander Leschanz on 18.07.26.
//

import Foundation
import Network
import Observation

@Observable
class NetworkMonitor {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "InternetMonitor")

    var hasInternet = false
    var isOnWifi = false

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.hasInternet = (path.status == .satisfied)
                self?.isOnWifi = path.usesInterfaceType(.wifi)
            }
        }
        monitor.start(queue: queue)
    }

    deinit {
        monitor.cancel()
    }
}
