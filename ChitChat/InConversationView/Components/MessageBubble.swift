//
//  MessageBubbleUtils.swift
//  ChitChat
//
//  Created by Alexander Leschanz on 19.07.26.
//

import Foundation
import SwiftUI

struct MessageBubble: View {
    let message: Message
    let isLastInGroup: Bool

    var body: some View {
        HStack {
            if message.isFromMe { Spacer(minLength: 60) }

            Text(message.text)
                .font(.system(size: 17))
                .foregroundStyle(message.isFromMe ? .white : .primary)
                .padding(.horizontal, 12)
                .padding(.vertical, 7)
                .background(bubbleShape.fill(bubbleColor))
                .frame(
                    maxWidth: .infinity,
                    alignment: message.isFromMe ? .trailing : .leading
                )

            if !message.isFromMe { Spacer(minLength: 60) }
        }
    }

    private var bubbleColor: Color {
        message.isFromMe ? .blue : Color(uiColor: .systemGray5)
    }

    private var bubbleShape: UnevenRoundedRectangle {
        let tail: CGFloat = isLastInGroup ? 4 : 18
        return UnevenRoundedRectangle(
            topLeadingRadius: 18,
            bottomLeadingRadius: message.isFromMe ? 18 : tail,
            bottomTrailingRadius: message.isFromMe ? tail : 18,
            topTrailingRadius: 18,
            style: .continuous
        )
    }
}
