//
//  MovieOverviewSection.swift
//  Movies
//
//  Created by Mina Magdy on 03/04/2026.
//

import SwiftUI

struct MovieOverviewSection: View {
    let overview: String

    var body: some View {
        Text(overview)
            .font(.body)
            .foregroundColor(.white)
            .lineSpacing(4)
            .padding(.horizontal, 16)
    }
}
