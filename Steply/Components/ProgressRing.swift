//
//  ProgressRing.swift
//  Steply
//
//  Created by Aysel Mohbaliyeva on 22.05.26.
//

import SwiftUI

struct ProgressRing: View {
    let progress: Double
    let lineWidth: CGFloat
    
    private var gradient: AngularGradient {
        AngularGradient(
            colors: [.indigo, .purple, .indigo],
            center: .center,
            startAngle: .degrees(-90),
            endAngle: .degrees(270)
        )
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.indigo.opacity(0.1), lineWidth: lineWidth)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    gradient,
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: 1.0), value: progress)
        }
    }
}

#Preview {
    ProgressRing(progress: 0.5, lineWidth: 22)
        .frame(width: 200, height: 200)
        .padding()
}
