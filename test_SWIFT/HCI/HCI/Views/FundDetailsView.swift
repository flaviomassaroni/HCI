import SwiftUI

struct FundDetailsView: View {
    var group: Group
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .foregroundColor(Color.blue)
                VStack{
                    Text(group.name)
                        .font(.largeTitle)
                        .padding(.top, 20)
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                    Text("\(group.startDate) ---> \(group.endDate)")
                         .foregroundColor(.white)
                         .font(.system(size: 18))
                         .fontWeight(.semibold)
                         .padding(0)
                    Text("\(group.currentAmount, specifier: "%.0f")/\(group.totalAmount, specifier: "%.0f")€")
                        .font(.system(size: 35))
                        .padding(.top, 20)
                        .padding(.bottom, -1)
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                    HStack{
                        Text("\(Int((group.currentAmount / group.totalAmount) * 100))%")
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.leading, 20)
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 14)
                                .foregroundColor(Color.white)
                                .frame(height: 20)
                                .padding(.vertical, 0)
                                .padding(.trailing, 20)
                            ProgressBar(value: group.currentAmount / group.totalAmount )
                                .frame(height: 20)
                                .padding(.vertical, 0)
                                .padding(.trailing, 20)
                        }
                    }
                }
            }
            .frame(height: 280)
            .padding(.top, -50)
            
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
                    Text("\(contribution.0): \(contribution.1, specifier: "%.0f")€")
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
