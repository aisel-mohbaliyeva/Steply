import Foundation
import Observation

struct WeekDay: Identifiable {
    let id = UUID()
    let name: String
    let steps: Int
}

struct Award: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let isUnlocked: Bool
}

@Observable
class StepData {
    var currentSteps: Int = 5001
    var dailyGoal: Int = 10000
    var notificationsEnabled: Bool = true

    let weeklySteps: [WeekDay] = [
        WeekDay(name: "Wed", steps: 2000),
        WeekDay(name: "Thu", steps: 7000),
        WeekDay(name: "Fri", steps: 3000),
        WeekDay(name: "Sat", steps: 5000),
        WeekDay(name: "Sun", steps: 8000),
        WeekDay(name: "Mon", steps: 10000),
        WeekDay(name: "Tue", steps: 22000),
        WeekDay(name: "Wed", steps: 5001)
    ]

    let awards: [Award] = [
        Award(name: "Walking", icon: "figure.walk", isUnlocked: true),
        Award(name: "Soccer", icon: "soccerball", isUnlocked: false),
        Award(name: "Running", icon: "figure.run", isUnlocked: false),
        Award(name: "Cooldown", icon: "figure.cooldown", isUnlocked: false),
        Award(name: "Medal", icon: "medal.fill", isUnlocked: false),
        Award(name: "Court", icon: "sportscourt.fill", isUnlocked: false)
    ]

    var progress: Double {
        min(Double(currentSteps) / Double(dailyGoal), 1.0)
    }

    var soccerFields: Int {
        Int(Double(currentSteps) * 0.75 / 110.0)
    }
}
