import SwiftUI

struct NotificationView: View {
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var group: Group
    
    var body: some View {
        NavigationView{
            VStack(spacing:0){
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .foregroundColor(Color.blue)
                        .frame(height: 280)
                        .padding(.top, -50)
                    VStack {
                        ZStack{
//                            HStack{
//                                NavigationLink(destination: FundDetailsView(group:group)){
//                                    Image(systemName: "arrow.backward")
//                                        .resizable()
//                                        .frame(width: 25, height: 20)
//                                        .foregroundColor(.white)
//                                        .padding(.leading, 20)
//                                        .padding(.top, 20)
//                                    Spacer()
//                                }
//                            }
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
                            }
                        Spacer()
                            Text(group.name)
                                .font(.largeTitle)
                                .padding(.top, 20)
                                .foregroundColor(Color.white)
                                .fontWeight(.semibold)

                        Spacer()
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
                ScrollView{
                    ZStack{
                        RoundedRectangle(cornerRadius: 14)
                        
                        
                        HStack {
                            Image(systemName: "exclamationmark.triangle")
                                .resizable()
                                .frame(width: 75, height: 70)
                                .foregroundColor(Color(hex: "FFB800"))
                                .padding(.vertical,10)
                                .padding(.horizontal, 20)
                            Spacer()
                            VStack(alignment: .leading) {
                                HStack{
                                    Text("Warning")
                                        .foregroundColor(Color(hex: "6C6C6C"))
                                        .fontWeight(.bold)
                                        .font(.system(size: 20))
                                    Spacer()
                                }
                                .padding(.leading, 40)
                                Text("You are not up to date with contributions")
                                    .foregroundColor(Color(hex: "FFB800"))
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                    .padding(.leading, -20)
                            }
                        }
                    }.frame(width: 380, height: 80)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    Text("Contributions To Pay")
                        .padding(.trailing, 180)
                        .padding()
                        .fontWeight(.semibold)
                        .foregroundColor(Color(hex: "6C6C6C"))
                        .font(.system(size: 20))
                    
                    ForEach(group.contributionHistory, id: \.id) { contribution in
                        HStack {
                            Text("\(contribution.amount, specifier: "%.0f")€")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                            Spacer()
                            Text("\(contribution.date)")
                                .font(.system(size: 17))
                            
                            
                        }
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)
                        .background(Color.white) // Background color
                        .cornerRadius(14) // Apply corner radius to the background
                        
                        .padding(.horizontal, 20)
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: 14)
                        HStack {
                            Text("Total: \(10.0, specifier: "%.0f")€")
                                .foregroundColor(Color(.black))
                                .fontWeight(.semibold)
                                .font(.system(size: 28))
                                .multilineTextAlignment(.center)
                                .padding(.leading, 35)
                            Spacer()
                            Button("Add Missing Contribution") {
                            }
                            .frame(width: 140, height: 55)
                            .background(Color(hex:"62DF57"))
                            .cornerRadius(14)
                            .padding(.trailing, 15)
                            .fontWeight(.bold)
                            .shadow(color: .gray, radius: 5, x: 0, y: 1)
                            
                            
                            
                        }
                        
                    }.frame(width: 380, height: 80)
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    
                    
                    
                }.background(Color(hex:"ECECEC"))
                
//                RoundedRectangle(cornerRadius: 14)
//                    .foregroundColor(Color.blue)
//                    .frame(height: 100)
//                    .padding(.bottom, -34)
                
            }.background(Color(hex:"ECECEC"))
        }.navigationBarHidden(true)

    }
}
struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView(group: Group(name: "Graduation present", creationDate: "23/05/24", startDate: "23/05/24", endDate: "30/06/25", period:(1, "M"), totalAmount: 6000,  currentAmount: 550, contributionHistory: [
            Contribution(owner: Participant(name:"Andrea Salinetti", colour: Color(hex: "FF5733")), date: "01/05/24", amount: 100.0),
            Contribution(owner: Participant(name:"Flavio Massaroni", colour: Color(hex: "3357FF")), date: "01/05/24", amount: 100.0),
            Contribution(owner:Participant(name:"Leonardo Scappatura", colour: Color(hex: "33FF57")), date: "01/05/24", amount: 100.0),
            Contribution(owner: Participant(name:"Andrea Salinetti", colour: Color(hex: "FF5733")), date: "01/05/24", amount: 100.0)],
         participants: [
              Participant(name:"Andrea Salinetti", colour: Color(hex: "FF5733")),
              Participant(name:"Andrea Salinetti", colour: Color(hex: "33FF57")),
              Participant(name:"Andrea Salinetti", colour: Color(hex: "3357FF"))
        ]))
    }
}

