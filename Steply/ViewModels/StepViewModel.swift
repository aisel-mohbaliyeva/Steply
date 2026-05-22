//
//  StepViewModel .swift
//  Steply
//
//  Created by Aysel Mohbaliyeva on 22.05.26.
//

import SwiftUI

@Observable
final class StepViewModel {
    
    private let service = HealthKitService()
    
    var todaySteps: Int = 0
    var weeklySteps: [DailySteps] = []
    var dailyGoal: Int = 10_000
    var isLoading = true
    var errorMessage: String?
    

    let awards: [Award] = [
            Award(name: "First Steps", icon: "figure.walk", requirement: 1_000),
            Award(name: "Getting Active", icon: "flame.fill", requirement: 3_000),
            Award(name: "Halfway There", icon: "star.fill", requirement: 5_000),
            Award(name: "Runner Up", icon: "figure.run", requirement: 7_500),
            Award(name: "Goal Crusher", icon: "trophy.fill", requirement: 10_000),
            Award(name: "Superstar", icon: "bolt.fill", requirement: 15_000)
        ]
    
    var progress: Double {
        guard dailyGoal > 0 else { return 0 }
        return min(Double(todaySteps) / Double(dailyGoal), 1.0)
    }
    
    var calories: Int {
        Int(Double(todaySteps) * 0.04)
    }
    
    var distance: Double {
        Double(todaySteps) * 0.0008
    }
    
    var goalReached: Bool {
        todaySteps >= dailyGoal
    }
    
    func loadData() async {
        isLoading = true
        errorMessage = nil
        
        do {
            try await service.requestAuthorization()
            
            async let todayResult = service.fetchTodaySteps()
            async let weekResult = service.fetchWeeklySteps()
            
            let (today, week) = try await (todayResult, weekResult)
            
            todaySteps = today
            weeklySteps = week
        } catch {
            errorMessage = error.localizedDescription
            loadMockData()
        }
        
        isLoading = false
    }
    
    private func loadMockData() {
        let calendar = Calendar.current
        let today = Date()
        
        todaySteps = 5_001
        weeklySteps = (0..<7).compactMap { day in
            guard let date = calendar.date(byAdding: .day, value: -day, to: today) else { return nil }
            let mockSteps = [5_001, 8_432, 12_205, 3_876, 9_540, 7_123, 6_890]
            return DailySteps(date: date, steps: mockSteps[day])
        }.reversed()
    }
}



