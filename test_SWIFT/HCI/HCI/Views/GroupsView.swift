// Views/GroupsView.swift
import SwiftUI

struct GroupsView: View {
    @EnvironmentObject var viewModel: FinanceViewModel
    @State private var navigateToHomepage = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Groups")
                    .font(.largeTitle)
                    .padding()
                
                List(viewModel.groups) { group in
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
                .listStyle(PlainListStyle())
                
                HStack {
                    Button(action: {
                        navigateToHomepage = true
                    })  {
                        VStack {
                            Image(systemName: "person")
                            Text("Personal")
                        }
                        .padding()
                    }
                    Spacer()
                    Button(action: {
                        // Do nothing or add functionality if needed
                    }) {
                        VStack {
                            Image(systemName: "person.3")
                            Text("Groups")
                        }
                        .padding()
                    }
                }
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
                
                NavigationLink(destination: HomePage().navigationBarHidden(true), isActive: $navigateToHomepage) {
                    EmptyView()
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
