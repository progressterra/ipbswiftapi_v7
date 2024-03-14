//
//  NetworkConnectivityChecker.swift
//
//  Created by Artemy Volkov on 01.11.2023.
//

import Network
import Combine

public final class NetworkConnectivityChecker {
    public static let shared = NetworkConnectivityChecker()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")

    @Published public var isConnected: Bool = true
    
    private init() {}

    public func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }

    public func stopMonitoring() {
        monitor.cancel()
    }
}
