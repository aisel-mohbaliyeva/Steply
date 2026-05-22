//
//  StepModel.swift
//  Steply
//
//  Created by Aysel Mohbaliyeva on 22.05.26.
//

import Foundation

struct DailySteps: Identifiable {
    let id = UUID()
    let date: Date
    let steps: Int
    
    var distance: Double {
        Double(steps) * 0.0008
    }
    
    var calories: Int {
        Int(Double(steps) * 0.04)
    }
}
struct Award: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let requirement: Int
    
    func isUnlocked(steps: Int) -> Bool {
        steps >= requirement
    }
}
