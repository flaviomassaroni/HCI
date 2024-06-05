import SwiftUI

struct GroupsView: View {
    @EnvironmentObject var viewModel: FinanceViewModel
    @State private var showingCreateFundView = false
    
    var body: some View {
        NavigationView {
            VStack(spacing:0) {
                ZStack{
                    RoundedRectangle(cornerRadius: 14)
                    .foregroundColor(Color.blue)
                    Text("Groups")
                        .font(.largeTitle)
                        .padding()
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                }
                .frame(height:200)
                .padding(.top, -50)
                
                
                List(viewModel.groups) { group in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(group.name)
                                .font(.system(size: 25))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            HStack{
                                Text("\(group.startDate) --> \(group.endDate)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("\(group.currentAmount, specifier: "%.0f")/\(group.totalAmount, specifier: "%.0f")€")
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .font(.system(size: 17))
                            }
                            ProgressBar(value: group.currentAmount / group.totalAmount)
                                .scaleEffect(CGSize(width: 1.0, height: 0.8))
                                .cornerRadius(14)
                            }

                            
                            
                        
                    }
                }
                .listStyle(DefaultListStyle())
                    .sheet(isPresented: $showingCreateFundView) {
                        CreateFundView()
                    }
                }
            }
            .background(Color(hex: "ECECEE"))
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
