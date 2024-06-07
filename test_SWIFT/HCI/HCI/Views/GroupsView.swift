import SwiftUI

struct GroupsView: View {
    @StateObject private var viewModel = FinanceViewModel()

    @State private var showingCreateFundView = false

    var body: some View {
        NavigationView {
            ZStack {
                // Main background color
                Color(hex: "ECECEE")
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 0) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 14)
                            .foregroundColor(Color.blue)
                        Text("Groups")
                            .font(.largeTitle)
                            .padding()
                            .foregroundColor(Color.white)
                            .fontWeight(.semibold)
                    }
                    .frame(height: 200)
                    .padding(.top, -50)

                    // List with consistent background color
                    List(viewModel.groups) { group in
                        ZStack(alignment: .topTrailing) {
                            NavigationLink(destination: FundDetailsView(group: group)) {
                                EmptyView()
                            }
                            .opacity(0) // Make the default chevron invisible

                            HStack {
                                VStack(alignment: .leading) {
                                    Text(group.name)
                                        .font(.system(size: 25))
                                        .fontWeight(.bold)
                                        .padding(.vertical, 5)
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
                                        Text("\(Int((group.currentAmount / group.totalAmount) * 100))%")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .foregroundColor(.black)
                                    }
                                }
                                Spacer()
                            }
                            .padding(5)
                            // Custom chevron at the top right corner
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding(.trailing, 10)
                                .padding(.top, 18)
                        }
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                        .padding(.vertical, 5)
                    }
                    .listStyle(DefaultListStyle())
                }
                .navigationTitle("Funds")
                .navigationBarHidden(true) // Hide the back button

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
                
//                HStack {
//                    Spacer()
//                    NavigationLink(destination: CreateFundView()) {
//                        Image(systemName: "plus")
//                            .padding()
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                            .shadow(radius: 5)
//                    }
//                    .padding()
//                }
//                Spacer()
                
            }
        }
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView()
    }
}
