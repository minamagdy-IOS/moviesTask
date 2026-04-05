//
//  ConnectivityStatusProviding.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//

import Foundation

/// Domain-layer abstraction for network connectivity. Keeps the Presentation
/// layer decoupled from the concrete ReachabilityService in the Data layer.
protocol ConnectivityStatusProviding: AnyObject {
    var onChange: ((Bool) -> Void)? { get set }
    func isSatisfied() -> Bool
}
