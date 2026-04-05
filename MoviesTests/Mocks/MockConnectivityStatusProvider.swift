//
//  MockConnectivityStatusProvider.swift
//  MoviesTests
//
//  Created by Mina Magdy on 04/04/2026.
//

import Foundation
@testable import Movies

final class MockConnectivityStatusProvider: ConnectivityStatusProviding {
    var onChange: ((Bool) -> Void)?
    private var _isSatisfied: Bool
    
    init(isSatisfied: Bool = true) {
        self._isSatisfied = isSatisfied
    }
    
    func isSatisfied() -> Bool {
        return _isSatisfied
    }
    
    func setConnectivity(_ connected: Bool) {
        _isSatisfied = connected
        onChange?(connected)
    }
}
