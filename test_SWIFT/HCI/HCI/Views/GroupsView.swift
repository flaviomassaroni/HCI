// Views/GroupsView.swift
import SwiftUI

struct GroupsView: View {
    @EnvironmentObject var viewModel: FinanceViewModel
    
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
                    NavigationLink(destination: HomePage()) {
                        VStack {
                            Image(systemName: "person")
                            Text("Personal")
                        }
                        .padding()
                    }
                    Spacer()
                    NavigationLink(destination: GroupsView()) {
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
            }
            .navigationTitle("Funds")
        }
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView().environmentObject(FinanceViewModel())
    }
}
