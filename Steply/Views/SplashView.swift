//
//  SplashView.swift
//  Steply
//
//  Created by Aysel Mohbaliyeva on 24.05.26.
//

import SwiftUI

struct SplashView: View {
    @State private var showContent = false
    @State private var isFinished = false
    
    var body: some View {
        if isFinished {
            ContentView()
        } else {
            ZStack {
                Color.indigo.ignoresSafeArea()
                
                VStack(spacing: 12) {
                    Text("Steply")
                        .font(.system(size: 44, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                    
                    Text("Every step counts")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.7))
                }
                .opacity(showContent ? 1 : 0)
                .scaleEffect(showContent ? 1 : 0.9)
            }
            .onAppear {
                withAnimation(.easeOut(duration: 0.6)) {
                    showContent = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isFinished = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
