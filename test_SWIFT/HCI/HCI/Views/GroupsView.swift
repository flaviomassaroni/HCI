import SwiftUI

struct GroupsView: View {
    @EnvironmentObject var viewModel: FinanceViewModel

    @State private var showingCreateFundView = false
    
    var body: some View {
        NavigationView {
            VStack {
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
                    NavigationLink(destination: FundDetailsView(group: group)) {
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
                }
                .listStyle(DefaultListStyle())
                
                Spacer()
                
                // Add a floating button at the bottom right
                HStack {
                    Spacer()
                    Button(action: {
                        showingCreateFundView = true
                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding()
                    .sheet(isPresented: $showingCreateFundView) {
                        CreateFundView()
                    }
                }
            }
            .background(Color(hex: "ECECEE"))
            .navigationTitle("Groups")
            .navigationBarHidden(true) // Hide the back button
        }
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView().environmentObject(FinanceViewModel())
    }
}
