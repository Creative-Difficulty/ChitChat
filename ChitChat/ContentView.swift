//
//  ContentView.swift
//  ChitChat
//
//  Created by Alexander Leschanz on 17.07.26.
//

import SwiftUI
import SwiftData
import Network

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @StateObject private var p2pWifi = WiFiMessageProtocol()
    @State private var currentDraftMessage = ""
        
    
    var body: some View {
        VStack {
            List(p2pWifi.log.indices, id: \.self) { Text(p2pWifi.log[$0]) }
            
            HStack {
                TextField("Message", text: $currentDraftMessage)
                Button {
                    p2pWifi.send(text: currentDraftMessage); currentDraftMessage = ""
                } label: {
                    Image(systemName: "arrow.up")
                        .font(.system(size: 18, weight: .semibold))
                        .frame(width: 44, height: 44)
                }
                .disabled(currentDraftMessage.isEmpty)
                .buttonBorderShape(.circle)
                .backgroundStyle(Color.blue)
            }
            .padding()
            
        }
        .onAppear { p2pWifi.start() }
    }
}

#Preview {
    ContentView()
}
