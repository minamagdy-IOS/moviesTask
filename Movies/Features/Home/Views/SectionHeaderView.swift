//
//  SectionHeaderView.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//

import SwiftUI

struct SectionHeaderView: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.system(size: 26, weight: .bold, design: .default))
            .foregroundStyle(AppTheme.accentYellow)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
