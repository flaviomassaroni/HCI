import SwiftUI

private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .clear
        appearance.backgroundEffect = nil
        
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
    
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        appearance.shadowImage = UIImage()
    }

struct MainView: View {
//    init() {
//            setupTabBarAppearance()
//        }
    
    var body: some View {
        TabView {
            HomePage()
                .tabItem {
                    Image(systemName: "person")
                    Text("Personal")
                }
            
            GroupsView()
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Groups")
                }
        }.tint(.white)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(FinanceViewModel())
    }
}
