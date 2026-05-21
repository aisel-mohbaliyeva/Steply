import SwiftUI

struct ContentView: View {
    @State private var stepData = StepData()

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            AwardsView()
                .tabItem {
                    Label("Awards", systemImage: "trophy.fill")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "slider.horizontal.3")
                }
        }
        .tint(.indigo)
        .environment(stepData)
    }
}

#Preview {
    ContentView()
}
