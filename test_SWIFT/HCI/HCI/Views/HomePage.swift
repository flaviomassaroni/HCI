// Views/HomePage.swift
import SwiftUI

struct HomePage: View {
    @EnvironmentObject var viewModel: FinanceViewModel
    @State private var navigateToGroups = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Your Balance")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "creditcard")
                            .foregroundColor(.white)
                    }
                    Text("€\(viewModel.balance, specifier: "%.2f")")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .padding()
                
                Text("Your Transactions")
                    .font(.headline)
                    .padding(.leading)
                
                List(viewModel.transactions) { transaction in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(transaction.name)
                                .font(.headline)
                            Text("\(transaction.date) \(transaction.time)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text("\(transaction.amount, specifier: "%.2f")€")
                            .font(.headline)
                        Text(transaction.location)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .listStyle(PlainListStyle())
                
                HStack {
                    Button(action: {
                        // Do nothing or add functionality if needed
                    }) {
                        VStack {
                            Image(systemName: "person")
                            Text("Personal")
                        }
                        .padding()
                    }
                    Spacer()
                    Button(action: {
                        navigateToGroups = true
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
                
                NavigationLink(destination: GroupsView().navigationBarHidden(true), isActive: $navigateToGroups) {
                    EmptyView()
                }
            }
            .navigationTitle("HomePage")
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage().environmentObject(FinanceViewModel())
    }
}
