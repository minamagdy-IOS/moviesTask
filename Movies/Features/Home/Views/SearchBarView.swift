//
//  SearchBarView.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    var prompt: String = "Search TMDB"

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.body.weight(.medium))
                .foregroundStyle(AppTheme.searchPlaceholder)
            TextField("", text: $text, prompt: Text(prompt).foregroundStyle(AppTheme.searchPlaceholder))
                .textFieldStyle(.plain)
                .foregroundStyle(.white)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.body)
                        .foregroundStyle(AppTheme.searchPlaceholder)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(AppTheme.searchBarFill)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}
