import SwiftUI

struct ContentView: View {
    @State private var viewModel = StepViewModel()
    
    var body: some View {
        TabView {
            HomeView(viewModel: viewModel)                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            AwardsView(viewModel: viewModel)
                .tabItem {
                    Label("Awards", systemImage: "trophy.fill")
                }
            
            SettingsView(viewModel: viewModel)
                .tabItem {
                    Label("Settings", systemImage: "slider.horizontal.3")
                }
        }
        .tint(.indigo)
    }
}

#Preview {
    ContentView()
}
