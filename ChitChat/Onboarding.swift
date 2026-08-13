//
//  Onboarding.swift
//  ChitChat
//
//  Created by Alexander Leschanz on 07.08.26.
//

import SwiftUI

struct Onboarding: View {
    @State private var showOnboarding: Bool = true
    
    var body: some View {
        VStack {
            Text("View Text")
        }
        .sheet(isPresented: $showOnboarding) {StocksOnboardingReference()}
//        .sheet(isPresented: $showOnboarding) {sheetOnboarding(showOnboarding: $showOnboarding)}.interactiveDismissDisabled()
    }
}

struct sheetOnboarding: View {
    @Binding var showOnboarding: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Text("Hi")
            Spacer()
        }
        .safeAreaInset(edge: .bottom) {
            Button {
                showOnboarding = false
            } label: {
                Text("Continue")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .padding(.horizontal)
        }
    }
}
#Preview {
    Onboarding()
}
