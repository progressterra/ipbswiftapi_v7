//
//  NetworkConnectivityChecker.swift
//
//  Created by Artemy Volkov on 01.11.2023.
//

import Network
import Combine

/// A utility class for monitoring network connectivity changes.
///
/// `NetworkConnectivityChecker` uses `NWPathMonitor` to listen for network changes and updates its `isConnected` property accordingly. It's implemented as a singleton to provide a unified source of truth regarding the network connectivity status across the entire application.
///
/// ## Usage
///
/// You typically start and stop monitoring network connectivity based on your app's lifecycle to efficiently manage resources. For instance, you can begin monitoring when your app becomes active and stop monitoring when it moves to the background.
///
/// ## Topics
///
/// ### Singleton Access
///
/// - ``shared``
///
/// ### Connectivity Monitoring
///
/// - ``startMonitoring()``
/// - ``stopMonitoring()``
///
/// ### Connectivity Status
///
/// - ``isConnected``
///
public final class NetworkConnectivityChecker {
    /// The singleton instance for accessing the network connectivity checker.
    public static let shared = NetworkConnectivityChecker()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    
    /// A boolean publisher value indicating whether the network is currently reachable.
    @Published public var isConnected: Bool = true
    
    private init() {}
    
    /// Starts monitoring for network connectivity changes.
    ///
    /// Updates the `isConnected` property based on the current network status. Monitoring runs asynchronously on a background queue and updates are published on the main queue.
    public func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
    
    /// Stops monitoring for network connectivity changes.
    ///
    /// Cancels the current network monitoring. It's important to stop monitoring when it's no longer needed to free up resources.
    public func stopMonitoring() {
        monitor.cancel()
    }
}
