import SwiftUI

// MARK: - Reference recreation of the Apple "Stocks" onboarding screen
// Use this as a structural reference for ChitChat's onboarding.

struct StocksOnboardingReference: View {
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Title
                    VStack(alignment: .center, spacing: 0) {
                        Text("Welcome to")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundStyle(.white)
                        Text("Stocks")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundStyle(.blue)
                    }
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.top, 60)
                    .padding(.bottom, 56)

                    // Feature rows
                    VStack(alignment: .leading, spacing: 32) {
                        FeatureRow(
                            systemImage: "chart.line.uptrend.xyaxis",
                            title: "Market Data",
                            description: "View stock quotes, interactive charts, and other financial metrics."
                        )
                        FeatureRow(
                            systemImage: "newspaper.fill",
                            title: "Business News",
                            description: "Read the latest stories driving the market."
                        )
                        FeatureRow(
                            systemImage: "laptopcomputer.and.iphone",
                            title: "On All Your Devices",
                            description: "Use iCloud to view your symbols and watchlists across your Apple devices."
                        )
                    }
                    .padding(.horizontal, 28)
                }
            }

            // Bottom-pinned privacy blurb + CTA
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 12) {
                    Image(systemName: "person.2.fill")
                        .foregroundStyle(.blue)
                        .font(.system(size: 22))
                    (
                        Text("Apple collects your activity in Stocks, which is not associated with your Apple Account, in order to improve and personalize Stocks. Your Apple Account may be used to check for news subscriptions, where available, so you can access them in Stocks. \(Text("See how your data is managed…").foregroundStyle(.blue))")
                    )
                    .font(.footnote)
                }

                Button {
                    // handle continue
                } label: {
                    Text("Continue")
                        .font(.system(size: 20, weight: .semibold))
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
                .padding(.horizontal, 24)
            }
            .padding(.horizontal, 28)
            .padding(.bottom, 12)
        }
        .background(Color.black)
        .preferredColorScheme(.dark)
    }
}

private struct FeatureRow: View {
    let systemImage: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: systemImage)
                .font(.system(size: 34))
                .foregroundStyle(.blue)
                .frame(width: 44)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.white)
                Text(description)
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    StocksOnboardingReference()
}
