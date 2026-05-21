import SwiftUI

struct SettingsView: View {
    @Environment(StepData.self) var stepData
    @State private var isEditingGoal = false
    @State private var goalText = ""

    var body: some View {
        @Bindable var stepData = stepData

        VStack(alignment: .leading, spacing: 24) {
            HStack(spacing: 10) {
                Image(systemName: "gearshape.fill")
                    .font(.title)
                    .foregroundStyle(.gray)
                Text("Settings")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Daily Steps Goal")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    Spacer()
                    Button {
                        goalText = "\(stepData.dailyGoal)"
                        isEditingGoal = true
                    } label: {
                        Image(systemName: "pencil.circle")
                            .font(.title3)
                            .foregroundStyle(.gray)
                    }
                }
                Text("\(stepData.dailyGoal.formatted()) steps")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.indigo)
            }
            .padding(20)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 8) {
                    Image(systemName: "bell")
                        .foregroundStyle(.gray)
                    Text("NOTIFICATION SETTINGS")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                        .tracking(0.5)
                }

                Toggle("Notifications", isOn: $stepData.notificationsEnabled)
                    .tint(.indigo)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding(.top, 24)
        .alert("Daily Steps Goal", isPresented: $isEditingGoal) {
            TextField("Steps", text: $goalText)
                .keyboardType(.numberPad)
            Button("Save") {
                if let goal = Int(goalText), goal > 0 {
                    stepData.dailyGoal = goal
                }
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}
