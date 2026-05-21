import SwiftUI

struct HomeView: View {
    @Environment(StepData.self) var stepData

    var body: some View {
        NavigationStack {
            ZStack {
                MountainBackgroundView()

                VStack {
                    Spacer()

                    NavigationLink(destination: StepDetailView()) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Current Steps")
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                                Text("\(stepData.currentSteps.formatted()) steps")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.indigo)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.gray)
                                .font(.title3)
                        }
                        .padding(20)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
                }
            }
            .ignoresSafeArea(edges: .top)
        }
    }
}

// MARK: - Mountain Background

struct MountainBackgroundView: View {
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height

            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.82, green: 0.94, blue: 0.98),
                        Color(red: 0.88, green: 0.96, blue: 0.99)
                    ],
                    startPoint: .top,
                    endPoint: .center
                )

                MountainCliffShape()
                    .fill(LinearGradient(
                        colors: [
                            Color(red: 0.80, green: 0.70, blue: 0.60),
                            Color(red: 0.74, green: 0.64, blue: 0.54)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ))

                SnowPatchShape()
                    .fill(.white.opacity(0.7))

                ForestLayerShape(yRatio: 0.50, treeWidth: 22, maxX: 0.40, seed: 3)
                    .fill(Color(red: 0.35, green: 0.55, blue: 0.38).opacity(0.45))

                ForestLayerShape(yRatio: 0.58, treeWidth: 20, maxX: 0.38, seed: 7)
                    .fill(Color(red: 0.28, green: 0.48, blue: 0.32).opacity(0.65))

                ForestLayerShape(yRatio: 0.67, treeWidth: 18, maxX: 0.36, seed: 11)
                    .fill(Color(red: 0.20, green: 0.40, blue: 0.25).opacity(0.80))

                let dots: [(CGFloat, CGFloat, Bool)] = [
                    (0.79, 0.13, false),
                    (0.77, 0.35, false),
                    (0.79, 0.55, true),
                    (0.77, 0.75, true)
                ]

                ForEach(0..<dots.count, id: \.self) { i in
                    Circle()
                        .stroke(Color.indigo, lineWidth: 2.5)
                        .background(
                            Circle().fill(dots[i].2 ? Color.indigo.opacity(0.15) : Color.clear)
                        )
                        .frame(width: 18, height: 18)
                        .position(x: w * dots[i].0, y: h * dots[i].1)
                }
            }
        }
    }
}

struct MountainCliffShape: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        var path = Path()
        path.move(to: CGPoint(x: w * 0.50, y: 0))
        path.addLine(to: CGPoint(x: w, y: 0))
        path.addLine(to: CGPoint(x: w, y: h))
        path.addLine(to: CGPoint(x: w * 0.36, y: h))
        path.addCurve(
            to: CGPoint(x: w * 0.50, y: 0),
            control1: CGPoint(x: w * 0.40, y: h * 0.60),
            control2: CGPoint(x: w * 0.52, y: h * 0.22)
        )
        return path
    }
}

struct SnowPatchShape: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        var path = Path()
        path.move(to: CGPoint(x: w * 0.46, y: h * 0.36))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.62, y: h * 0.30),
            control: CGPoint(x: w * 0.54, y: h * 0.24)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.52, y: h * 0.42),
            control: CGPoint(x: w * 0.58, y: h * 0.38)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.46, y: h * 0.36),
            control: CGPoint(x: w * 0.48, y: h * 0.40)
        )
        return path
    }
}

struct ForestLayerShape: Shape {
    let yRatio: CGFloat
    let treeWidth: CGFloat
    let maxX: CGFloat
    let seed: Int

    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        let baseY = h * yRatio
        var path = Path()

        path.move(to: CGPoint(x: 0, y: baseY))

        var x: CGFloat = 0
        var i = 0
        let limit = w * maxX
        while x < limit {
            let variation = CGFloat((i * seed + 5) % 11) / 10.0
            let treeH: CGFloat = 15 + 20 * variation
            path.addLine(to: CGPoint(x: x + treeWidth * 0.5, y: baseY - treeH))
            path.addLine(to: CGPoint(x: x + treeWidth, y: baseY))
            x += treeWidth
            i += 1
        }

        path.addLine(to: CGPoint(x: limit, y: h))
        path.addLine(to: CGPoint(x: 0, y: h))
        path.closeSubpath()

        return path
    }
}
