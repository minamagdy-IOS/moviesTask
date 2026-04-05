//
//  ReachabilityService.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//


import Foundation
import Network

final class ReachabilityService: ConnectivityStatusProviding, @unchecked Sendable {
    private let lock = NSLock()
    private var satisfied = true
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "com.movies.reachability")

    var onChange: ((Bool) -> Void)?

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.apply(path.status == .satisfied)
        }
        monitor.start(queue: queue)
    }

    private func apply(_ ok: Bool) {
        lock.lock()
        let unchanged = satisfied == ok
        if !unchanged { satisfied = ok }
        lock.unlock()
        guard !unchanged else { return }
        DispatchQueue.main.async { [weak self] in
            self?.onChange?(ok)
        }
    }

    func isSatisfied() -> Bool {
        lock.lock()
        defer { lock.unlock() }
        return satisfied
    }
}
