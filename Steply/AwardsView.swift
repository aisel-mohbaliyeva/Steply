import SwiftUI

struct AwardsView: View {
    @Environment(StepData.self) var stepData

    private let columns = [
        GridItem(.flexible(), spacing: 24),
        GridItem(.flexible(), spacing: 24)
    ]

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 8) {
                    Text("🏆")
                        .font(.largeTitle)
                    Text("Weekly Awards")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .padding(.horizontal)

                Text("Can you can unlock all of these awards this week?")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .padding(.horizontal)

                LazyVGrid(columns: columns, spacing: 28) {
                    ForEach(stepData.awards) { award in
                        NavigationLink(destination: AwardDetailView(award: award)) {
                            AwardCircleView(award: award)
                        }
                    }
                }
                .padding(.horizontal, 36)
                .padding(.top, 20)

                Spacer()
            }
            .padding(.top, 24)
        }
    }
}

struct AwardCircleView: View {
    let award: Award

    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    award.isUnlocked ? Color.indigo : Color.indigo.opacity(0.2),
                    lineWidth: award.isUnlocked ? 3 : 2
                )
            Image(systemName: award.icon)
                .font(.system(size: 36))
                .foregroundStyle(
                    award.isUnlocked ? Color.indigo : Color.indigo.opacity(0.3)
                )
        }
        .frame(width: 100, height: 100)
    }
}
