//
//  AppTheme.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//

import SwiftUI

enum AppTheme {
    /// True black screen background.
    static let background = Color(red: 0, green: 0, blue: 0)
    /// Primary accent (titles, selected chip, chip borders).
    static let accentYellow = Color(red: 1, green: 0.84, blue: 0)
    /// Search field background (charcoal).
    static let searchBarFill = Color(red: 0.17, green: 0.17, blue: 0.17)
    static let searchPlaceholder = Color.white.opacity(0.45)
    static let secondaryText = Color.white.opacity(0.55)
    static let chipBorderWidth: CGFloat = 1.5
}
