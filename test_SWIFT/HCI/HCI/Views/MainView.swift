import SwiftUI

struct MainView: View {
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
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(FinanceViewModel())
    }
}
