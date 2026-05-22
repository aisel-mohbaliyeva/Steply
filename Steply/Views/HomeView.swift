//
//  HomeView.swift
//  Steply
//
//  Created by Aysel Mohbaliyeva on 22.05.26.
//

import SwiftUI

struct HomeView: View {
    
    var viewModel: StepViewModel
    var body: some View {
        
        ScrollView {
            VStack(spacing: 24) {
                
                headerSection
                
                progressSection
                
                statsSection
                
                weeklySection
                
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .task {
            await viewModel.loadData()
        }
    }
    
    // MARK: - Header
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Today")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text("\(viewModel.todaySteps.formatted()) steps")
                .font(.system(size: 36, weight: .bold))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - Progress Ring
    
    private var progressSection: some View {
        ZStack {
            ProgressRing(progress: viewModel.progress, lineWidth: 22)
            
            VStack(spacing: 4) {
                Text("\(Int(viewModel.progress * 100))%")
                    .font(.system(size: 40, weight: .bold))
                Text("of daily goal")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(width: 200, height: 200)
        .padding(.vertical, 8)
    }
    
    // MARK: - Stats Cards
    
    private var statsSection: some View {
        HStack(spacing: 12) {
            StatCard(
                icon: "flame.fill",
                value: "\(viewModel.calories)",
                unit: "kcal",
                title: "Calories"
            )
            StatCard(
                icon: "figure.walk",
                value: String(format: "%.1f", viewModel.distance),
                unit: "km",
                title: "Distance"
            )
            StatCard(
                icon: "target",
                value: "\(Int(viewModel.progress * 100))",
                unit: "%",
                title: "Goal"
            )
        }
    }
    
    // MARK: - Weekly Chart
    
    private var weeklySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("This Week")
                .font(.headline)
            
            HStack(alignment: .bottom, spacing: 8) {
                ForEach(viewModel.weeklySteps) { day in
                    VStack(spacing: 6) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(
                                day.date.isToday
                                    ? Color.indigo
                                    : Color.indigo.opacity(0.3)
                            )
                            .frame(
                                height: barHeight(for: day.steps)
                            )
                        
                        Text(day.date.shortWeekday)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(height: 140)
            .padding(.top, 4)
        }
        .padding(16)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private func barHeight(for steps: Int) -> CGFloat {
        let maxSteps = viewModel.weeklySteps.map(\.steps).max() ?? 1
        return CGFloat(steps) / CGFloat(maxSteps) * 120
    }
}

// MARK: - Date Helpers

extension Date {
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    var shortWeekday: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: self)
    }
}

#Preview {
    HomeView(viewModel: StepViewModel())
}
