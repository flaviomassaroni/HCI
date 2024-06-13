import SwiftUI

@main
struct HCIApp: App {
    @StateObject private var financeModel = FinanceViewModel()
        
        var body: some Scene {
            WindowGroup {
                HomePage()
            }
        }
    }
