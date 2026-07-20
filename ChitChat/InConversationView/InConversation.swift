import SwiftUI
import Network

struct Message: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isFromMe: Bool
}

struct MessagesView: View {
    @State private var messages: [Message] = [
        Message(text: "Hey! Are we still on for lunch tomorrow?", isFromMe: false),
        Message(text: "Yes! 12:30 at the usual spot 🙂", isFromMe: true),
        Message(text: "I'll grab us a table by the window", isFromMe: true),
        Message(text: "Perfect, see you then!", isFromMe: false)
    ]


    @State private var draft: String = ""
    @State private var networkMonitor = NetworkMonitor()
    @FocusState private var inputFocused: Bool;
    

    var body: some View {
        VStack(spacing: 0) {
            TopBar(contactFullName: "Example Contact", missedMessagesCount: 3, networkMonitor: networkMonitor)
            // Message list
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
                            deliveredReceipt
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
                .onTapGesture { inputFocused = false }
            }
            inputBar
        }
    }

    // MARK: Top bar
    private var timestampHeader: some View {
        Text("\(Text("Today").fontWeight(.medium)) 9:41 AM")
            .font(.system(size: 11))
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 6)
    }

    private var deliveredReceipt: some View {
        HStack {
            Spacer()
            Text("Delivered")
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(.secondary)
                .padding(.trailing, 4)
                .padding(.top, 2)
        }
    }

    // MARK: Input bar
    private var inputBar: some View {
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

    // MARK: Optimistic send function, TODO: impl actual send
    private func send() {
        guard !draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
            messages.append(Message(text: draft, isFromMe: true))
        }
        draft = ""
    }

    private func isLastInGroup(at index: Int) -> Bool {
        guard index < messages.count - 1 else { return true }
        return messages[index].isFromMe != messages[index + 1].isFromMe
    }
}


#Preview {
    MessagesView()
}
