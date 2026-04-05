//
//  MovieInfoSection.swift
//  Movies
//
//  Created by Mina Magdy on 03/04/2026.
//

import SwiftUI

struct MovieInfoSection: View {
    let homepage: String?
    let languages: String
    let status: String
    let runtime: String
    let budget: String
    let revenue: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let homepage, !homepage.isEmpty {
                DetailRow(label: "Homepage:", value: homepage, isLink: true)
            }

            DetailRow(label: "Languages:", value: languages)

            HStack(spacing: 40) {
                DetailRow(label: "Status:", value: status)
                DetailRow(label: "Runtime:", value: runtime)
            }

            HStack(spacing: 40) {
                DetailRow(label: "Budget:", value: budget)
                DetailRow(label: "Revenue:", value: revenue)
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
    }
}

private struct DetailRow: View {
    let label: String
    let value: String
    var isLink: Bool = false

    var body: some View {
        HStack(alignment: .top, spacing: 4) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.white)

            if isLink, let url = URL(string: value) {
                Link(destination: url) {
                    Text(value)
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        .underline()
                        .lineLimit(1)
                }
            } else {
                Text(value)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}
