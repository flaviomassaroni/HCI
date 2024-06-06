import SwiftUI

struct FundDetailsView: View {
    var group: Group
    
    var body: some View {
        VStack{
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .foregroundColor(Color.blue)
                    .frame(height: 280)
                    .padding(.top, -50)
                VStack {
                    Text(group.name)
                        .font(.largeTitle)
                        .padding(.top, 20)
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                    Text("\(group.startDate) ---> \(group.endDate)")
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                    Text("\(group.currentAmount, specifier: "%.0f")/\(group.totalAmount, specifier: "%.0f")€")
                        .font(.system(size: 35))
                        .padding(.top, 20)
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                    HStack {
                        Text("\(Int((group.currentAmount / group.totalAmount) * 100))%")
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.leading, 20)

                        ZStack {
                            RoundedRectangle(cornerRadius: 14)
                                .foregroundColor(Color.white)
                                .frame(height: 20)
                                .padding(.trailing, 20)
                            ProgressBar(value: group.currentAmount / group.totalAmount)
                                .frame(height: 20)
                                .padding(.trailing, 20)
                        }
                    }
                }
            }
            ScrollView {
                VStack(spacing: 0) {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.white)
                        HStack {
                            Image(systemName: "info.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.blue)
                                .padding()
                            Spacer()
                            VStack(alignment: .leading) {
                                HStack{
                                    Text("Info")
                                        .foregroundColor(Color(hex: "6C6C6C"))
                                        .fontWeight(.bold)
                                        .font(.system(size: 20))
                                    Spacer()
                                }
                                .padding(.leading, 110)
                                
                                if let nextContribution = addPeriodToDate(dateString: group.startDate, period: group.period) {
                                    Text("Next Contribution: \(nextContribution)")
                                        .fontWeight(.semibold)
                                        .padding(.leading, 20)
            
                                } else {
                                    Text("Invalid date or period")
                                }
                            }
                            .padding(.trailing, 20)
                            Spacer()
                        }
                    }
                    .padding(.top, 30)
                    .frame(height: 50)
                    .padding(.horizontal, 20)
                    HStack{
                        Text("Participants")
                            .padding(.top, 30)
                            .padding(.leading, 20)
                            .foregroundColor(Color(hex: "747476"))
                            .font(.system(size: 20))
                        Spacer()
                    }
                    .padding(.top, 20)
                    .padding(.bottom , 10)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .padding(.leading, 30)
                            Text("You")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .padding(.vertical, 10)
                    }
                    .padding(.bottom, 8)
                    .padding(.horizontal, 20)
                    
                    ForEach(group.participants, id: \.self) { participant in

                        HStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text(participant)
                            Spacer()
                        }
                        .padding(.horizontal, 33)
                        .padding(.vertical, 10)
                        .background()
                        .cornerRadius(14)
                        .padding(.vertical, 1)
                        .padding(.horizontal, 20)
                        
                        
                    }
                    
                    
                    HStack{
                        Text("Contribution History")
                            .padding(.top, 10)
                            .padding(.leading, 20)
                            .foregroundColor(Color(hex: "747476"))
                            .font(.system(size: 20))
                        Spacer()
                    }
                    .padding(.top, 20)
                    .padding(.bottom , 10)
                    ForEach(group.contributionHistory, id: \.0) { contribution in
                        
                        HStack {
                            RoundedRectangle(cornerRadius: 25.0)
                                .frame(width: 20)
                            Text("\(contribution.0): \(contribution.1, specifier: "%.0f")€")
                            Spacer()
                        }
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)
                        .background()
                        .padding(.vertical, 1)
                        .padding(.horizontal, 20)
                    }
                    
                }
                .background(Color(hex: "ECECEC"))
            }
        }
        .background(Color(hex: "ECECEC"))
    }
}

struct FundDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FundDetailsView(group: Group(name: "Boat", startDate: "23/05/24", endDate: "30/06/25", period:"1M", totalAmount: 6000,  currentAmount: 550, contributionHistory: [
            ("01/05/24", 100.0),
            ("15/05/24", 150.0),
            ("01/06/24", 200.0),
            ("15/06/24", 100.0)],
        participants: ["Andrea Salinetti", "Leonardo Scappatura", "Flavio Massaroni"]))
    }
}
