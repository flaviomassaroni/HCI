import SwiftUI

@main
struct HCIApp: App {
    @StateObject private var viewModel = FinanceViewModel()
        
        var body: some Scene {
            WindowGroup {
                MainView()
                    .environmentObject(viewModel)
            }
        }
    }
