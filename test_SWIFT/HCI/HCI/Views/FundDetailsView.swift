import SwiftUI

struct FundDetailsView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @ObservedObject var financeModel: FinanceViewModel
    @State var showOverlay: Bool = false
    var group: Group
    
    var body: some View {
        ZStack {
            if showOverlay {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)

                
                GroupMenuView(isVisible: $showOverlay)
                    .zIndex(1.0)
            }
            NavigationView {
                VStack(spacing: 0) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 14)
                            .foregroundColor(Color.blue)
                            .frame(height: 280)
                            .padding(.top, -50)
                        VStack {
                            HStack {
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }, label: {
                                    Image(systemName: "arrow.backward")
                                        .resizable()
                                        .frame(width: 25, height: 20)
                                        .foregroundColor(.white)
                                        .padding(.leading, 20)
                                        .padding(.top, 20)
                                })
                                Spacer()
                                Text(group.name)
                                    .font(.largeTitle)
                                    .padding(.top, 20)
                                    .foregroundColor(Color.white)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                Button(action: {
                                    showOverlay = true
                                }, label: {
                                    Image(systemName: "ellipsis")
                                        .resizable()
                                        .rotationEffect(.degrees(90.0))
                                        .frame(width: 30, height: 7)
                                        .padding(.top, 25)
                                        .padding(.trailing, 20)
                                        .foregroundColor(.white)
                                })
                            }
                            
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
                                        HStack {
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
                            ScrollView {
                                HStack {
                                    Text("Participants")
                                        .padding(.top, 30)
                                        .padding(.leading, 20)
                                        .foregroundColor(Color(hex: "747476"))
                                        .font(.system(size: 20))
                                    Spacer()
                                }
                                .padding(.top, 20)
                                .padding(.bottom, 10)
                                
                                NavigationLink(destination: PersonalNotificationView(financeModel: financeModel, group: .constant(group), participant: group.participants[0])) {
                                    HStack {
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                            .padding(.leading)
                                            .foregroundColor(Color.black)
                                        Text("You")
                                            .fontWeight(.semibold)
                                            .foregroundColor(.black)
                                        Spacer()
                                        if (group.contributionHistory.filter { !$0.paid && comesBeforeToday(dateString: $0.date) && $0.owner.name == "You" }.count != 0) {
                                            Image(systemName: "exclamationmark.triangle")
                                                .resizable()
                                                .frame(width: 28, height: 25)
                                                .foregroundColor(Color(hex: "FFB800"))
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.black)
                                                .padding(.trailing, 17)
                                        } else {
                                            Image(systemName: "checkmark.circle")
                                                .resizable()
                                                .frame(width: 28, height: 25)
                                                .foregroundColor(Color(hex: "62DF57"))
                                                .padding(.trailing, 17)
                                        }
                                    }
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 11)
                                    .background()
                                    .cornerRadius(14)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                }
                                .disabled(group.contributionHistory.filter { !$0.paid && comesBeforeToday(dateString: $0.date) && $0.owner.name == "You" }.isEmpty)
                                
                                ForEach(group.participants.filter { $0.name != "You" }, id: \.id) { participant in
                                    NavigationLink(destination: FriendNotificationView(financeModel: financeModel, participant: participant, group: group)) {
                                        HStack {
                                            Image(systemName: "person.circle.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(participant.colour)
                                            
                                            Text(participant.name)
                                                .foregroundColor(.black)
                                            Spacer()
                                            if (group.contributionHistory.filter { !$0.paid && comesBeforeToday(dateString: $0.date) && $0.owner == participant }.count != 0) {
                                                Image(systemName: "exclamationmark.triangle")
                                                    .resizable()
                                                    .frame(width: 28, height: 25)
                                                    .foregroundColor(Color(hex: "FFB800"))
                                                Image(systemName: "chevron.right")
                                                    .foregroundColor(.black)
                                            } else {
                                                Image(systemName: "checkmark.circle")
                                                    .resizable()
                                                    .frame(width: 28, height: 25)
                                                    .foregroundColor(Color(hex: "62DF57"))
                                            }
                                        }
                                        .padding(.horizontal, 33)
                                        .padding(.vertical, 10)
                                        .background()
                                        .cornerRadius(14)
                                        .padding(.vertical, 1)
                                        .padding(.horizontal, 20)
                                    }
                                    .disabled(group.contributionHistory.filter { !$0.paid && comesBeforeToday(dateString: $0.date) && $0.owner == participant }.isEmpty)
                                }
                            }
                            
                            HStack {
                                Text("Contribution History")
                                    .padding(.top, 10)
                                    .padding(.leading, 20)
                                    .foregroundColor(Color(hex: "747476"))
                                    .font(.system(size: 20))
                                Spacer()
                            }
                            .padding(.top, 20)
                            .padding(.bottom, 10)
                            ForEach(group.contributionHistory.filter { $0.paid }, id: \.id) { contribution in
                                HStack {
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .frame(width: 20, height: 20) // Adjust height as needed
                                        .foregroundColor(contribution.owner.colour) // Provide a color here
                                    Text("\(contribution.date): \(contribution.amount, specifier: "%.0f")€")
                                    Spacer()
                                }
                                .padding(.horizontal, 40)
                                .padding(.vertical, 10)
                                .background(Color.white) // Background color
                                .cornerRadius(14) // Apply corner radius to the background
                                .padding(.vertical, 1)
                                .padding(.horizontal, 20)
                            }
                        }
                        .background(Color(hex: "ECECEC"))
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
                .background(Color(hex: "ECECEC"))
            }
        }
        .navigationBarHidden(true)
    }
}

struct FundDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FundDetailsView(
            financeModel: FinanceViewModel(),
            group: Group(name: "Graduation present", creationDate: "23/05/24", startDate: "23/05/24", endDate: "30/06/25", period: (1, "M"), totalAmount: 6000, currentAmount: 550, contributionAmount: 100, contributionHistory: [
                Contribution(owner: Participant(name: "You", colour: Color(hex: "000000")), date: "01/05/24", amount: 100.0, paid: false)
            ],
            participants: [
                Participant(name: "Andrea Salinetti", colour: Color(hex: "FF5733")),
                Participant(name: "Andrea Salinetti", colour: Color(hex: "33FF57")),
                Participant(name: "Andrea Salinetti", colour: Color(hex: "3357FF"))
            ]
        ))
    }
}
