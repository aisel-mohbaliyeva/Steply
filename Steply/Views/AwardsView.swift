//
//  AwardsView.swift
//  Steply
//
//  Created by Aysel Mohbaliyeva on 23.05.26.
//

import SwiftUI

struct AwardsView: View {
    var viewModel: StepViewModel
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.awards) { award in
                        let unlocked = award.isUnlocked(steps: viewModel.todaySteps)
                        
                        VStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .stroke(
                                        unlocked ? Color.indigo : Color.gray.opacity(0.2),
                                        lineWidth: 3
                                    )
                                    .frame(width: 80, height: 80)
                                
                                Image(systemName: award.icon)
                                    .font(.system(size: 30))
                                    .foregroundStyle(
                                        unlocked ? .indigo : .gray.opacity(0.3)
                                    )
                            }
                            
                            Text(award.name)
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundStyle(unlocked ? .primary : .secondary)
                            
                            Text("\(award.requirement.formatted()) steps")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Awards")
        }
    }
}

#Preview {
    AwardsView(viewModel: StepViewModel())
}
