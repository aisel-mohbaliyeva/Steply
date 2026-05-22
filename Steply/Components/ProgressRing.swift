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
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.indigo.opacity(0.15), lineWidth: lineWidth)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.indigo,
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: 0.8), value: progress)
        }
    }
}

#Preview {
    ProgressRing(progress: 0.5, lineWidth: 22)
        .frame(width: 200, height: 200)
        .padding()
}
