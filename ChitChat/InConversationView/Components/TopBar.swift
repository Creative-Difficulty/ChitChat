//
//  TopBar.swift
//  ChitChat
//
//  Created by Alexander Leschanz on 19.07.26.
//

import SwiftUI

struct TopBar: View {
    let contactFullName: String
    let missedMessagesCount: Int
    let networkMonitor: NetworkMonitor;

    private var initials: String {
        let parts = contactFullName.split(separator: " ")
        let first = parts.first?.first.map(String.init) ?? ""
        let last = parts.dropFirst().first?.first.map(String.init) ?? ""
        return first + last
    }

    var body: some View {
            HStack(alignment: .bottom) {
                // Back chevron + unread badge
                HStack(spacing: 6) {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 21, weight: .semibold))
                        .foregroundStyle(.blue)
                    Text("\(missedMessagesCount)")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 7)
                        .padding(.vertical, 2)
                        .background(Capsule().fill(.blue))
                }
                .padding(.bottom, 18)

                Spacer()

                // MARK: Connection Status
                Image(systemName: networkMonitor.hasInternet ? "wifi.circle" : "wifi.exclamationmark.circle")
                    .font(.system(size: 22, weight: .regular))
                    .foregroundStyle(networkMonitor.hasInternet ? .blue : .black)            .padding(.bottom, 20)
                    .padding(.trailing, 4)
            }
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity)
            .frame(height: 88)
            .overlay(alignment: .bottom) {
                // Centered avatar + name
                VStack(spacing: 3) {
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [Color(white: 0.62), Color(white: 0.50)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(width: 50, height: 50)
                        Text(initials)
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(.white)
                    }
                    HStack(spacing: 3) {
                        Text(contactFullName)
                            .font(.system(size: 12))
                            .foregroundStyle(.primary)
                    }
                }
                .padding(.bottom, 5)
            }
            .background(.ultraThinMaterial)
            .overlay(alignment: .bottom) {
                Divider()
            }
    }
}

#Preview {
    TopBar(contactFullName: "Jane Appleseed", missedMessagesCount: 2, networkMonitor: NetworkMonitor())
}
