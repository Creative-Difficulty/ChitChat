//
//  MessageList.swift
//  ChitChat
//
//  Created by Alexander Leschanz on 21.07.26.
//

import SwiftUI

struct MessageList: View {
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 2) {
                    timestampHeader
                    ForEach(Array(messages.enumerated()), id: \.element.id) { index, message in
                        MessageBubble(
                            message: message,
                            isLastInGroup: isLastInGroup(at: index)
                        )
                    }
                    if let last = messages.last, last.isFromMe {
                        HStack {
                            Spacer()
                            Text("Delivered")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundStyle(.secondary)
                                .padding(.trailing, 4)
                                .padding(.top, 2)
                        }
                    }
                }
                .padding(.horizontal, 12)
                .padding(.top, 8)
            }
            .background(Color(uiColor: .systemBackground))
            .onChange(of: messages){
                if let lastID = messages.last?.id {
                withAnimation(.easeOut(duration: 0.25)) {
                    proxy.scrollTo(lastID, anchor: .bottom)
                }
            }}
//            .onTapGesture { inputFocused = false }
        }
    }
}

#Preview {
    MessageList()
}
