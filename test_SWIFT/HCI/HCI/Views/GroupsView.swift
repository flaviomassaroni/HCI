import SwiftUI

struct GroupsView: View {
    @EnvironmentObject var viewModel: FinanceViewModel
    @State private var showingCreateFundView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Groups")
                    .font(.largeTitle)
                    .padding()
                
                List(viewModel.groups) { group in
                    NavigationLink(destination: FundDetailsView(group: group)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(group.name)
                                    .font(.headline)
                                Text("\(group.startDate) - \(group.endDate)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("\(group.currentAmount, specifier: "%.2f")/\(group.totalAmount, specifier: "%.2f")€")
                                    .font(.headline)
                                ProgressBar(value: group.currentAmount / group.totalAmount)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
                
                Spacer()
                
                // Add a floating button at the bottom right
                HStack {
                    Spacer()
                    Button(action: {
                        showingCreateFundView = true
                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding()
                    .sheet(isPresented: $showingCreateFundView) {
                        CreateFundView()
                    }
                }
            }
            .navigationTitle("Funds")
            .navigationBarHidden(true) // Hide the back button
        }
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView().environmentObject(FinanceViewModel())
    }
}
