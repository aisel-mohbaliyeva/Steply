//
//  HealthKitService.swift
//  Steply
//
//  Created by Aysel Mohbaliyeva on 22.05.26.
//

import HealthKit

final class HealthKitService {
    
    private let healthStore = HKHealthStore()
    
    private let stepType = HKQuantityType(.stepCount)
    
    var isAvailable: Bool {
        HKHealthStore.isHealthDataAvailable()
    }
    
    func requestAuthorization() async throws {
        guard isAvailable else { return }
        
        try await healthStore.requestAuthorization(
            toShare: [],
            read: [stepType]
        )
    }
    
    func fetchTodaySteps() async throws -> Int {
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startOfDay,
            end: now,
            options: .strictStartDate
        )
        
        let descriptor = HKStatisticsQueryDescriptor(
            predicate: .quantitySample(type: stepType, predicate: predicate),
            options: .cumulativeSum
        )
        
        let result = try await descriptor.result(for: healthStore)
        let quantity = result?.sumQuantity()
        let steps = quantity?.doubleValue(for: .count()) ?? 0
        
        return Int(steps)
    }
    
    func fetchWeeklySteps() async throws -> [DailySteps] {
        let calendar = Calendar.current
        let now = Date()
        var weekData: [DailySteps] = []
        
        for day in 0..<7 {
            guard let date = calendar.date(byAdding: .day, value: -day, to: now) else { continue }
            let start = calendar.startOfDay(for: date)
            guard let end = calendar.date(byAdding: .day, value: 1, to: start) else { continue }
            
            let predicate = HKQuery.predicateForSamples(
                withStart: start,
                end: end,
                options: .strictStartDate
            )
            
            let descriptor = HKStatisticsQueryDescriptor(
                predicate: .quantitySample(type: stepType, predicate: predicate),
                options: .cumulativeSum
            )
            
            let result = try await descriptor.result(for: healthStore)
            let quantity = result?.sumQuantity()
            let steps = Int(quantity?.doubleValue(for: .count()) ?? 0)
            
            weekData.append(DailySteps(date: date, steps: steps))
        }
        
        return weekData.reversed()
    }
}
