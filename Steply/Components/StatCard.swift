//
//  StatCard.swift
//  Steply
//
//  Created by Aysel Mohbaliyeva on 22.05.26.
//

import SwiftUI

struct StatCard: View {
    let icon: String
    let value: String
    let unit: String
    let title: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.indigo)
            
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(unit)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    HStack(spacing: 12) {
        StatCard(icon: "flame.fill", value: "200", unit: "kcal", title: "Calories")
        StatCard(icon: "figure.walk", value: "4.0", unit: "km", title: "Distance")
        StatCard(icon: "target", value: "50", unit: "%", title: "Goal")
    }
    .padding()
}
