import SwiftUI

// MARK: - Reference recreation of the Apple "Stocks" onboarding screen
// Use this as a structural reference for ChitChat's onboarding.

struct StocksOnboardingReference: View {
    var body: some View {
        VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    // Title
                    Spacer()
                    VStack(alignment: .center, spacing: 0) {
                        Text("Welcome to")
                            .font(.system(size: 44, weight: .bold))
                        Text("Stocks")
                            .font(.system(size: 44, weight: .bold))
                            .foregroundStyle(.blue)
                    }
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    
                    Spacer()
                    Spacer()
   


                    // Feature rows
                    VStack(alignment: .leading, spacing: 32) {
                        FeatureRow(
                            systemImage: "chart.line.uptrend.xyaxis",
                            title: "Market Data",
                            description: "View stock quotes, interactive charts, and other financial metrics."
                        )
                        FeatureRow(
                            systemImage: "newspaper",
                            title: "Business News",
                            description: "Read the latest stories driving the market."
                        )
                        FeatureRow(
                            systemImage: "laptopcomputer.and.iphone",
                            title: "On All Your Devices",
                            description: "Use iCloud to view your symbols and watchlists across your Apple devices."
                        )
                    }
                }
            
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            

            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 12) {
                    Image(systemName: "person.2.fill")
                        .foregroundStyle(.blue)
                        .font(.system(size: 22))
                    (
                        Text("Apple collects your activity in Stocks, which is not associated with your Apple Account, in order to improve and personalize Stocks. Your Apple Account may be used to check for news subscriptions, where available, so you can access them in Stocks. \(Text("See how your data is managed…").foregroundStyle(.blue))")
                    )
                    .font(.caption)
                    .foregroundStyle(.secondary)
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
            }
        }
//        .preferredColorScheme(.dark)
        .padding(.horizontal, 48)
    }
}

private struct FeatureRow: View {
    let systemImage: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: systemImage)
                .font(.system(size: 40))
                .foregroundStyle(.blue)
                .frame(width: 44)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.title3.weight(.semibold))
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
