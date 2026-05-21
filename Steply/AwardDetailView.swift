import SwiftUI

struct AwardDetailView: View {
    let award: Award

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            if award.isUnlocked {
                Image(systemName: "lock.open.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(.indigo)

                Text("Unlocked!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.indigo)

                Text("Congratulations! You've earned this award this week. Great job staying active!")
                    .font(.body)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            } else {
                Image(systemName: "lock.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(.indigo)

                Text("Locked")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.indigo)

                Text("You haven't unlocked this award yet this week. Keep getting those steps in to unlock it. You can do it!")
                    .font(.body)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }

            Spacer()
        }
        .navigationTitle("🏆 Weekly Awards")
        .navigationBarTitleDisplayMode(.inline)
    }
}
