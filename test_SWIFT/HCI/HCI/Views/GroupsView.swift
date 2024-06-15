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
    @ObservedObject var financeModel: FinanceViewModel
//    @StateObject private var financeModel = FinanceViewModel()
    @State private var selectedSortOption: SortOption = .creationDate
    @State private var selectedSortOrder: SortOrder = .ascending
    @State private var showingSortOptions = false
    @State private var showingCreateFundView = false
    @Binding var isShowingGroupsView: Bool
    
    var sortedGroups: [Group] {
        let sortedGroups: [Group]
        switch selectedSortOption {
        case .creationDate:
            sortedGroups = financeModel.groups.sorted(by: { $0.creationDate < $1.creationDate })
        case .startDate:
            sortedGroups = financeModel.groups.sorted(by: {
                guard let date1 = $0.startDateAsDate, let date2 = $1.startDateAsDate else { return false }
                return date1 < date2
            })
        case .endDate:
            sortedGroups = financeModel.groups.sorted(by: {
                guard let date1 = $0.endDateAsDate, let date2 = $1.endDateAsDate else { return false }
                return date1 < date2
            })
        }
        
        return selectedSortOrder == .ascending ? sortedGroups : sortedGroups.reversed()
    }


    var body: some View {
        NavigationView {
                VStack(spacing: 0) {
                    ZStack() {
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

                    ZStack {
                        ScrollView() {
                            HStack {
                                Spacer()
                                if !financeModel.groups.isEmpty{
                                    
                                    Button(action: {
                                        showingSortOptions = true
                                    }) {
                                        VStack(spacing:0){
                                            Image(systemName: "line.horizontal.3.decrease.circle")
                                                .font(.title)
                                                .foregroundColor(.blue)
                                                .padding()
                                            
                                            Text("Sort Groups")
                                                .padding(.top, -17)
                                        }.padding(.trailing, 20)
                                            .padding(.bottom, 10)
                                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                        
                                    }.padding(.top, -15)
                                    
                                        .sheet(isPresented: $showingSortOptions) {
                                            SortOptionsView(selectedSortOption: $selectedSortOption, selectedSortOrder: $selectedSortOrder)
                                                .presentationDetents([.fraction(0.5)])
                                        }}
                        }
                            ForEach(sortedGroups) { group in
                                ZStack {
                                    NavigationLink(destination: FundDetailsView(financeModel: financeModel, group: group)) {
                                        HStack {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 14)
                                                    .foregroundColor(.white)
                                                    .frame(height: 150)
                                                VStack(alignment: .leading) {
                                                    HStack {
                                                        Text(group.name)
                                                            .font(.system(size: 25))
                                                            .fontWeight(.bold)
                                                            .padding(.vertical, 5)
                                                            .foregroundColor(.black)
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
                                                            .foregroundColor(.black)
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
                                                }
                                                .padding(.horizontal, 20)
                                            }
                                        }
                                        .padding(1)
                                    }
                                    .padding(.horizontal, 15)
                                    .cornerRadius(8)
                                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                                }
                            }
                            
                        }
                        VStack{
                            Spacer()
                            HStack{
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
                                    CreateFundView(financeModel: financeModel)
                                }

                                }
                            }
                        }



                    ZStack{
                        RoundedRectangle(cornerRadius: 14)
                            .foregroundColor(Color.blue)
                            .frame(height: 100)
                        HStack{
                            Button(action: {
                                isShowingGroupsView = false
                                
                            }){
                                VStack{
                                    Image(systemName: "person")
                                        .resizable()
                                        .frame(width:22, height:22)
                                        .foregroundColor(.white)
                                    Text("Personal")
                                        .foregroundColor(.white)
                                }
                            }
                            Spacer()
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .frame(width: 1, height: 40)
                                .foregroundColor(.white)
                            Spacer()
                            
                                VStack{
                                    Image(systemName: "person.3.fill")
                                        .resizable()
                                        .frame(width:42, height:24)
                                        .foregroundColor(.white)
                                    Text("Groups")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                }
                            
                        }.padding(.horizontal, 80)
                    }

                    
                }.background(Color(hex: "ECECEE"))
                
                .edgesIgnoringSafeArea(.bottom)

        }.navigationBarHidden(true)
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView(financeModel: FinanceViewModel(), isShowingGroupsView: .constant(true))
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
//                UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
            })
        }
    }
}
