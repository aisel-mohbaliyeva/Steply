import SwiftUI

struct StepDetailView: View {
    @Environment(StepData.self) var stepData

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                HStack(spacing: 12) {
                    Image(systemName: "soccerball")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                    Text("You've walked about \(stepData.soccerFields) soccer fields today so far. Keep it up!")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)

                ZStack {
                    Circle()
                        .stroke(Color.indigo.opacity(0.15), lineWidth: 22)
                    Circle()
                        .trim(from: 0, to: stepData.progress)
                        .stroke(
                            Color.indigo,
                            style: StrokeStyle(lineWidth: 22, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))
                    VStack(spacing: 4) {
                        Text(stepData.currentSteps.formatted())
                            .font(.system(size: 44, weight: .bold))
                        Text("Steps")
                            .font(.title3)
                            .foregroundStyle(.gray)
                    }
                }
                .frame(width: 220, height: 220)

                VStack(alignment: .leading, spacing: 16) {
                    Text("Weekly Steps")
                        .font(.title3)
                        .fontWeight(.semibold)

                    WeeklyChartView()
                }
                .padding(.horizontal)
            }
            .padding(.top, 8)
        }
        .navigationTitle("Back")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Weekly Chart

struct WeeklyChartView: View {
    @Environment(StepData.self) var stepData

    private let maxValue: Double = 30000
    private let chartHeight: CGFloat = 170
    private let yLabels = [30000, 20000, 10000, 0]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 8) {
                ZStack(alignment: .bottom) {
                    VStack(spacing: 0) {
                        ForEach(yLabels, id: \.self) { value in
                            if value != 30000 { Spacer(minLength: 0) }
                            Rectangle()
                                .fill(Color.orange.opacity(0.25))
                                .frame(height: 0.5)
                        }
                    }
                    .frame(height: chartHeight)

                    let goalRatio = CGFloat(stepData.dailyGoal) / CGFloat(maxValue)
                    VStack(spacing: 0) {
                        Spacer(minLength: 0)
                            .frame(height: chartHeight * (1.0 - goalRatio))
                        DashedLine()
                            .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [6, 4]))
                            .foregroundStyle(.teal)
                            .frame(height: 1.5)
                        Spacer(minLength: 0)
                    }
                    .frame(height: chartHeight)

                    HStack(alignment: .bottom, spacing: 6) {
                        ForEach(stepData.weeklySteps) { day in
                            VStack(spacing: 4) {
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(Color.indigo)
                                    .frame(
                                        height: max(4, chartHeight * CGFloat(day.steps) / CGFloat(maxValue))
                                    )
                                Text(day.name)
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }

                VStack(alignment: .trailing) {
                    ForEach(yLabels, id: \.self) { value in
                        if value != 30000 { Spacer(minLength: 0) }
                        Text(formatYLabel(value))
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(width: 48, height: chartHeight)
            }

            HStack(spacing: 4) {
                Rectangle()
                    .fill(.teal)
                    .frame(width: 20, height: 2)
                Text("Daily Goal")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.top, 4)
        }
    }

    private func formatYLabel(_ value: Int) -> String {
        if value == 0 { return "0" }
        return "\(value / 1000),000"
    }
}

struct DashedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.width, y: rect.midY))
        return path
    }
}
