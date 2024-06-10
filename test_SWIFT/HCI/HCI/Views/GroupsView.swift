import SwiftUI

struct GroupsView: View {
    @StateObject private var viewModel = FinanceViewModel()

    @State private var showingCreateFundView = false

    var body: some View {
        NavigationView {
                VStack(spacing: 0) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 14)
                            .foregroundColor(Color.blue)
                            .padding(.bottom, 10)
                        Text("Groups")
                            .font(.largeTitle)
                            .padding()
                            .foregroundColor(Color.white)
                            .fontWeight(.semibold)
                    }
                    .frame(height: 200)
                    .padding(.top, -50)
                    ZStack{
                    ScrollView{
                        ForEach(viewModel.groups) { group in
                            ZStack(alignment: .topTrailing) {
                                NavigationLink(destination: FundDetailsView(group: group)) {
                                    EmptyView()
                                }
                                HStack {
                                    ZStack{
                                        
                                        
                                        RoundedRectangle(cornerRadius: 14)
                                            .foregroundColor(.white)
                                            .frame( height: 150)
                                        VStack(alignment: .leading) {
                                            HStack{
                                                Text(group.name)
                                                    .font(.system(size: 25))
                                                    .fontWeight(.bold)
                                                    .padding(.vertical, 5)
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                                    .foregroundColor(.gray)
                                                    .padding(.trailing, 10)
                                            }
                                            HStack {
                                                Text("\(group.startDate) --> \(group.endDate)")
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                                Spacer()
                                                Text("\(group.currentAmount, specifier: "%.0f")/\(group.totalAmount, specifier: "%.0f")€")
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 17))
                                            }
                                            HStack {
                                                ProgressBar(value: group.currentAmount / group.totalAmount)
                                                    .scaleEffect(CGSize(width: 1.0, height: 0.8))
                                                    .cornerRadius(14)
                                                    .frame(height: 30)
                                                Text("\(Int((group.currentAmount / group.totalAmount) * 100))%")
                                                    .font(.caption)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.black)
                                                    }
                                                }.padding(.horizontal, 20)
                                            }
                                        }

                                        .padding(1)
                                    }.padding(.horizontal, 15)
                                        .cornerRadius(8)
                                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                                }
                        }
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Button(action: {
                                    showingCreateFundView = true
                                }) {
                                    Image(systemName: "plus")
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(90)
                                        .shadow(radius: 5)
                                }
                                .padding()
                                .sheet(isPresented: $showingCreateFundView) {
                                    CreateFundView()
                                }
                            }
                            .padding(.bottom, 10)
                        }
                    }
                    RoundedRectangle(cornerRadius: 14)
                        .foregroundColor(Color.blue)
                        .frame(height: 100)

                    
                }.background(Color(hex: "ECECEE"))
                .navigationTitle("Funds")
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView()
    }
}
