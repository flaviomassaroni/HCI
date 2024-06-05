// Views/FundDetailsView.swift
import SwiftUI

struct FundDetailsView: View {
    var group: Group
    
    var body: some View {
        VStack {
            Text(group.name)
                .font(.largeTitle)
                .padding()
            
            Text("\(group.currentAmount, specifier: "%.2f")/\(group.totalAmount, specifier: "%.2f")€")
                .font(.headline)
            
            ProgressBar(value: group.currentAmount / group.totalAmount)
                .frame(height: 20)
                .padding()
            
            Text("Participants")
                .font(.headline)
                .padding(.top)
            
            List {
                // Add participants details here
                Text("You")
                Text("Andrey Salineiko")
                Text("Leonardo Scappatova")
            }
            
            Text("Contributions History")
                .font(.headline)
                .padding(.top)
            
            List {
                // Add contributions history here
                Text("16/05/24: 50€")
                Text("17/04/24: 50€")
                Text("24/03/24: 50€")
                // Add more contributions
            }
        }
        .navigationTitle("Fund Details View")
    }
}

struct FundDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FundDetailsView(group: Group(name: "Boat", startDate: "23/05/24", endDate: "30/06/25", totalAmount: 6000, currentAmount: 550))
    }
}
