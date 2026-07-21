//
//  InputBar.swift
//  ChitChat
//
//  Created by Alexander Leschanz on 21.07.26.
//

import SwiftUI

struct InputBar: View {
    var body: some View {
            HStack(alignment: .bottom, spacing: 10) {
                // Text field pill with trailing mic / send button
                HStack(alignment: .bottom, spacing: 0) {
                    TextField("Message", text: $draft, axis: .vertical)
                        .font(.system(size: 17))
                        .lineLimit(1...5)
                        .focused($inputFocused)
                        .padding(.leading, 12)
                        .padding(.vertical, 7)

                    if draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Button {} label: {
                            Image(systemName: "mic")
                                .font(.system(size: 17))
                                .foregroundStyle(Color(uiColor: .secondaryLabel))
                                .frame(width: 30, height: 34)
                        }
                        .transition(.opacity)
                    } else {
                        Button(action: send) {
                            Image(systemName: "arrow.up")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundStyle(.white)
                                .frame(width: 28, height: 28)
                                .background(Rectangle().size(CGSize(width: 20, height: 20)).fill(.blue)).cornerRadius(90)
                        }
                        .padding(.trailing, 3)
                        .padding(.bottom, 3)
                        .transition(.scale.combined(with: .opacity))
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .strokeBorder(Color(uiColor: .systemGray3), lineWidth: 1)
                )
                .animation(.spring(response: 0.25, dampingFraction: 0.8), value: draft.isEmpty)
            }
            .padding(.horizontal, 10)
            .padding(.top, 8)
            .padding(.bottom, 8)
            .background(Color(uiColor: .systemBackground))
    }
}

#Preview {
    InputBar()
}
