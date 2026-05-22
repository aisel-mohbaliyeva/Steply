//
//  SettingsView.swift
//  Steply
//
//  Created by Aysel Mohbaliyeva on 23.05.26.
//

import SwiftUI

struct SettingsView: View {
    @Bindable var viewModel: StepViewModel
    @State private var goalText = ""
    @State private var isEditingGoal = false
    
    var body: some View {
        NavigationStack {
            List {
                goalSection
                aboutSection
            }
            .navigationTitle("Settings")
            .alert("Daily Step Goal", isPresented: $isEditingGoal) {
                TextField("Steps", text: $goalText)
                    .keyboardType(.numberPad)
                Button("Save") {
                    if let goal = Int(goalText), goal > 0 {
                        viewModel.dailyGoal = goal
                    }
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
    
    // MARK: - Goal Section
    
    private var goalSection: some View {
        Section("Daily Goal") {
            HStack {
                Label("Step Goal", systemImage: "target")
                Spacer()
                Text("\(viewModel.dailyGoal.formatted()) steps")
                    .foregroundStyle(.secondary)
            }
            .onTapGesture {
                goalText = "\(viewModel.dailyGoal)"
                isEditingGoal = true
            }
        }
    }
    
    // MARK: - About Section
    
    private var aboutSection: some View {
        Section("About") {
            HStack {
                Label("Version", systemImage: "info.circle")
                Spacer()
                Text("1.0.0")
                    .foregroundStyle(.secondary)
            }
            
            Label("Made with ♥ by Aisel", systemImage: "heart.fill")
                .foregroundStyle(.indigo)
        }
    }
}

#Preview {
    SettingsView(viewModel: StepViewModel())
}
