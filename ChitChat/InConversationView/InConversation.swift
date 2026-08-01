import SwiftUI
import Network

struct InConversationData {
    let messageBoxFocused:  Bool
    let chatBelongsToContact: Contact
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
    
    @EnvironmentObject var conversationState: InConversationData
    
    var body: some View {
        VStack(spacing: 0) {
            TopBar(contactFullName: "Example Contact", missedMessagesCount: 3, networkMonitor: networkMonitor)
            // Message list
            
            InputBar()        }
    }

    // MARK: Top bar
    private var timestampHeader: some View {
        Text("\(Text("Today").fontWeight(.medium)) 9:41 AM")
            .font(.system(size: 11))
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 6)
    }

    // MARK: Optimistic send function, TODO: impl actual send
    private func send() {
        guard !draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
            messages.append(Message(text: draft, isFromMe: true))
        }
        draft = ""
    }

    func isLastInGroup(at index: Int) -> Bool {
        guard index < messages.count - 1 else { return true }
        return messages[index].isFromMe != messages[index + 1].isFromMe
    }
}


#Preview {
    MessagesView()
}
