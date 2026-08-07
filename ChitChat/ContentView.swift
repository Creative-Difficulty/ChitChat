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
    
    var body: some View {
        VStack {
            Text("ChitChat Test 1")
            .padding()
            
        }
        .onAppear { start() }
    }
}

#Preview {
    ContentView()
}
