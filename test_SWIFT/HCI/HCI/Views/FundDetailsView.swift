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
                ForEach(group.contributionHistory, id: \.0) { contribution in
                    Text("\(contribution.0): \(contribution.1, specifier: "%.2f")€")
                }
            }
        }
        .navigationTitle("Fund Details View")
    }
}

struct FundDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FundDetailsView(group: Group(name: "Boat", startDate: "23/05/24", endDate: "30/06/25", totalAmount: 6000, currentAmount: 550, contributionHistory: [
            ("01/05/24", 100.0),
            ("15/05/24", 150.0),
            ("01/06/24", 200.0),
            ("15/06/24", 100.0)
        ]))
    }
}
