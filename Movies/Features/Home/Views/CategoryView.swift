//
//  CategoryView.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//


import SwiftUI

struct CategoryView: View {
    let categories: [Genre]
    @Binding var selected: Int

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(Array(categories.enumerated()), id: \.offset) { index, genre in
                    let isSelected = index == selected
                    Button {
                        selected = index
                    } label: {
                        Text(genre.name ?? "—")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(isSelected ? Color.black : Color.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(isSelected ? AppTheme.accentYellow : AppTheme.background)
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .strokeBorder(AppTheme.accentYellow, lineWidth: AppTheme.chipBorderWidth)
                                    .opacity(isSelected ? 0 : 1)
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}
