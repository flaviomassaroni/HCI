import SwiftUI

enum SortOption: String, CaseIterable{
    case creationDate = "Creation Date"
    case startDate = "Start Date"
    case endDate = "End Date"
}

enum SortOrder: String, CaseIterable {
    case ascending = "Ascending"
    case descending = "Descending"
}

struct GroupsView: View {
    @StateObject private var viewModel = FinanceViewModel()
    @State private var selectedSortOption: SortOption = .creationDate
    @State private var selectedSortOrder: SortOrder = .ascending
    
    @State private var showingSortOptions = false
    @State private var showingCreateFundView = false
    
    var sortedGroups: [Group] {
        let sortedGroups: [Group]
        switch selectedSortOption {
        case .creationDate:
            sortedGroups = viewModel.groups.sorted(by: { $0.creationDate < $1.creationDate })
        case .startDate:
            sortedGroups = viewModel.groups.sorted(by: {
                guard let date1 = $0.startDateAsDate, let date2 = $1.startDateAsDate else { return false }
                return date1 < date2
            })
        case .endDate:
            sortedGroups = viewModel.groups.sorted(by: {
                guard let date1 = $0.endDateAsDate, let date2 = $1.endDateAsDate else { return false }
                return date1 < date2
            })
        }
        
        return selectedSortOrder == .ascending ? sortedGroups : sortedGroups.reversed()
    }


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
                    
                    List {
                        Section(header:
                            HStack {
                                Spacer() // This pushes the button to the right
                                Button(action: {
                                    showingSortOptions = true
                                }) {
                                    Image(systemName: "line.horizontal.3.decrease.circle")
                                        .font(.title)
                                        .foregroundColor(.blue)
                                        .padding()
                                }
                                .sheet(isPresented: $showingSortOptions) {
                                    SortOptionsView(selectedSortOption: $selectedSortOption, selectedSortOrder: $selectedSortOrder)
                                        .presentationDetents([.fraction(0.5)])
                                }
                            }
                            .padding(.trailing, -20) // Adjust the padding to your preference
                        ) {
                            ForEach(sortedGroups) { group in
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
                        }
                    }
                    .listStyle(.insetGrouped)
                }
                .navigationTitle("Groups")
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
                            CreateFundView(financeModel: viewModel)
                        }
                    }
                    .padding(.bottom, 10)
                }
            }
        }
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView()
    }
}


struct SortOptionsView: View {
    @Binding var selectedSortOption: SortOption
    @Binding var selectedSortOrder: SortOrder

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Order By")) {
                    Picker("Order", selection: $selectedSortOrder) {
                        ForEach(SortOrder.allCases, id: \.self) { order in
                            Text(order.rawValue).tag(order)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Sort by")) {
                    ForEach(SortOption.allCases, id: \.self) { option in
                        HStack {
                            Text(option.rawValue)
                            Spacer()
                            if selectedSortOption == option {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedSortOption = option
                        }
                    }
                }
            }
            .navigationTitle("Sort Options")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Done") {
                UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
            })
        }
    }
}
