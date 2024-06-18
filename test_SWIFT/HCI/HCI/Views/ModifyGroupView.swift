// Views/CreateFundView.swift
import SwiftUI
import Foundation

struct ModifyGroupView: View {
    
    //    @Binding var isPresented: Bool
    @Environment (\.dismiss) var dismiss
    
    @StateObject private var friendsModel = FriendsModel()
    @ObservedObject var financeModel: FinanceViewModel
    
    @State private var fundName: String = ""
    @State private var totalAmount: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var selectedNumber = 1
    @State private var selectedUnit = "Day"
    @State private var computedAmount: Double = 0.0
    @State private var newParticipant: String = ""
    @State private var participants: [Participant] = [Participant(name: "You", colour: .black)]
    @State private var error: [String] = ["", ""] // Errors section error[0] = Name, error[1] Total Amount
    @State private var missingValues: Bool = false
    @State private var colorIndex: Int = 1
    @Binding var group:Group
    @Binding var editMode:Bool
    @State private var isFriendsInputFocused: Bool = false
    
    
    private enum Field: Int, CaseIterable {
        case name, amount
    }
    @FocusState private var focusedField: Field?
    
    @State var screenWidth: CGFloat = UIScreen.main.bounds.width
    @State var screenHeight: CGFloat = UIScreen.main.bounds.height
    
    //    @State private var filteredFriends: [Friend] = []
    var filteredFriends: [Friend] {
        if newParticipant.isEmpty {
            return friendsModel.friends
        } else {
            //            print("friends: \(friendsModel.friends.filter { $0.name.lowercased().contains(newFriend.lowercased()) })")
            return friendsModel.friends.filter { $0.name.lowercased().contains(newParticipant.lowercased())}
        }
    }
    
    let numbers = Array(1...30)
    let unitOptions = ["Day", "Week", "Month", "Year"]
    var units: [String] {
        selectedNumber > 1 ? unitOptions.map{$0 + "s"}: unitOptions
    }
    
    var body: some View {
        
        ZStack{
            
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color.white) // Fill color of the rectangle
                .frame(width: geometry.size.width, height: geometry.size.height)}
            
        VStack (alignment: .center, spacing: 10){
            ZStack{
                RoundedRectangle(cornerRadius: 14)
                    .foregroundColor(Color.blue)
                
                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 70, height: 5)
                        .padding(.top, 5)
                        .foregroundColor(Color.gray)
                        .padding(.top, 5)
                    HStack {
                        Button(action:{
                            editMode = false
                        }){
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width:20, height:20)
                                .foregroundColor(.white)
                                .padding(.leading, 30)
                        }
                        Spacer()
                        Text("Modify Group")
                            .font(.largeTitle)
                            .padding()
                            .foregroundColor(Color.white)
                            .fontWeight(.semibold)
                        Spacer()
                        Spacer()
                    }
                }

                
            }
            .frame(width: screenWidth, height: 110)
            .padding(.top, -10)
            .onTapGesture {
                isFriendsInputFocused = false
                newParticipant = ""
            }
            
            GeometryReader { geometry in
                ScrollView {
                    VStack (spacing:10) {
                        //          Fund Name
                        ZStack {
                            RoundedRectangle(cornerRadius: 14)
                                .foregroundColor(Color.white)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 3)
                            
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Group Name")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .padding(.leading)
                                    .foregroundColor(Color.black)
                                
                                
                                ZStack(alignment: .trailing) {
                                    TextField("Fuerteventura's Trip", text: $fundName)
                                        .padding()
                                        .background(error[0].isEmpty ? Color(.systemGray6) : Color.red.opacity(0.2))
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                        .focused($focusedField, equals: .name)
                                        .onChange(of: fundName) { _ in
                                            checkFundName()
                                        }
                                    
                                    Button(action: {
                                        fundName = ""
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.horizontal)
                                    
                                }
                                .toolbar {
                                    ToolbarItem(placement: .keyboard) {
                                        Button("Done") {
                                            focusedField = nil
                                        }
                                    }
                                }
                                if !error[0].isEmpty {
                                    Text(error[0])
                                        .foregroundColor(.red)
                                        .font(.caption)
                                        .padding(.leading)
                                }
                            }
                            .padding(.horizontal, 5)
                            .padding(.vertical, 10)
                        }
                        .frame(width: screenWidth - 28, height: 86)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .padding(.top)
                        .padding(.bottom)
                        .onTapGesture {
                            isFriendsInputFocused = false
                            newParticipant = ""
                        }
                        
                        //          Amount
                        ZStack {
                            // borderColor red if error else white
                            RoundedRectangle(cornerRadius: 14)
                                .foregroundColor(Color.white)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 3)
                            
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Total amount to save")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .padding(.leading)
                                    .foregroundColor(Color.black)
                                
                                ZStack(alignment: .trailing) {
                                    HStack(spacing: 1) {
                                        Text("€")
                                            .fontWeight(.bold)
                                            .padding(.leading, 1.0)
                                        
                                        TextField("6000", text: $totalAmount)
                                            .padding()
                                            .background(error[1].isEmpty ? Color(.systemGray6) : Color.red.opacity(0.2))
                                            .cornerRadius(10)
                                            .padding(.horizontal, 5)
                                            .keyboardType(.numberPad)
                                    }
                                    .padding(.leading)
                                    
                                    Button(action: {
                                        totalAmount = ""
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.horizontal)
                                }
                                .padding(.trailing, 14)
                                
                                if !error[1].isEmpty {
                                    Text(error[1])
                                        .foregroundColor(.red)
                                        .font(.caption)
                                        .padding(.leading)
                                }
                                
                            }
                            .padding(.horizontal, 5)
                            .padding(.vertical, 10)
                        }
                        .frame(width: screenWidth - 28, height: 86)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .padding(.bottom)
                        .onTapGesture {
                            isFriendsInputFocused = false
                            newParticipant = ""
                        }
                        
                        
                        //          Date Picking
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: 14)
                                .foregroundColor(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 3)
                            
                            VStack {
                                HStack (spacing: 20){
                                    VStack (alignment: .center){
                                        Text("Start Date")
                                            .fontWeight(.bold)
                                            .padding(.bottom, -5)
                                        
                                        DatePicker(
                                            "",
                                            selection: $startDate,
                                            in: Date()...,
                                            displayedComponents: .date
                                        )
                                        .datePickerStyle(.compact)
                                        .labelsHidden()
                                        .padding()
                                        .disabled(true)
                                        
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    
                                    
                                    VStack (alignment: .center){
                                        Text("End Date")
                                            .fontWeight(.bold)
                                            .padding(.bottom, -5)
                                        
                                        DatePicker(
                                            "",
                                            selection: $endDate,
                                            in: startDate...,
                                            displayedComponents: .date
                                        )
                                        .datePickerStyle(.compact)
                                        .labelsHidden()
                                        .padding()
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                }
                                .padding(.horizontal, 5)
                                .padding(.vertical, 10)
                                
                                VStack {
                                    Text("Every")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .padding(.bottom, 5)
                                    
                                    HStack {
                                        Picker(selection: $selectedNumber, label: Text("Number")) {
                                            ForEach(numbers, id: \.self) { number in
                                                Text("\(number)").tag(number)
                                            }
                                        }
                                        .pickerStyle(WheelPickerStyle())
                                        .frame(width: 100, height: 150)
                                        .clipped()
                                        
                                        Picker(selection: $selectedUnit, label: Text("Unit")) {
                                            ForEach(units, id: \.self) { unit in
                                                Text(unit).tag(unit)
                                            }
                                        }
                                        .pickerStyle(WheelPickerStyle())
                                        .frame(width: 150, height: 150)
                                        .clipped()
                                    }
                                    .padding(.top, -10)
                                    
                                    
                                }
                                .onChange(of: selectedNumber) { _ in
                                    // Update selectedUnit to ensure it matches the correct plurality
                                    let unitSingular = selectedUnit.replacingOccurrences(of: "s", with: "")
                                    if selectedNumber > 1 && !selectedUnit.hasSuffix("s") {
                                        selectedUnit = unitSingular + "s"
                                    } else if selectedNumber == 1 && selectedUnit.hasSuffix("s") {
                                        selectedUnit = unitSingular
                                    }
                                    updateComputedAmount()
                                }
                                .onChange(of: selectedUnit) { _ in
                                    updateComputedAmount()
                                }
                                .onChange(of: startDate) { _ in
                                    updateComputedAmount()
                                }
                                .onChange(of: endDate) { _ in
                                    updateComputedAmount()
                                }
                                .onChange(of: totalAmount) { _ in
                                    updateComputedAmount()
                                }
                            }
                        }
                        .frame(width: screenWidth - 28, height: 86)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 110)
                        .padding(.bottom)
                        
                        //                Friends adding section
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: 14)
                                .foregroundColor(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 3)
                            
                            VStack(){
                                Text("Participants")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .padding(.top)
                                
                                HStack {
                                    TextField("Enter your friend's name", text: $newParticipant, onEditingChanged: { isEditing in
                                        isFriendsInputFocused = true
                                    })
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                    
                                    Button(action: {
                                        
                                        if !newParticipant.isEmpty {
                                            addParticipantIfNotExists(Participant(id: UUID(), name: newParticipant, colour:financeModel.profileColors[colorIndex] ))
                                            colorIndex += 1
                                            //                                            participants.insert(Participant(id: UUID(), name: newParticipant, colour: Color(hex: "FF5733")), at: 0)
                                            newParticipant = ""
                                            
                                        }
                                    }) {
                                        Image(systemName: "plus")
                                            .padding()
                                            .background(newParticipant.isEmpty ? Color.blue.opacity(0.5) : Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                    }.disabled(newParticipant.isEmpty)
                                    //                                    .opacity(fundName.isEmpty ? 0.5 : 1)
                                    //                                     .disabled(fundName.isEmpty ? true : false)
                                    
                                }
                                .padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        ForEach(participants, id: \.self) { participant in
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color.blue)
                                                    .frame(height: 40)
                                                HStack {
                                                    Text(participant.name)
                                                        .foregroundColor(.white)
                                                        .padding(.leading, 10)
                                                    Spacer()
                                                    if participant.name != "You"{
                                                        Button(action: {
                                                            if let index = participants.firstIndex(of: participant) {
                                                                participants.remove(at: index)
                                                            }
                                                        }) {
                                                            Image(systemName: "xmark.circle.fill")
                                                                .foregroundColor(.white)
                                                        }
                                                        .padding(.trailing, 10)
                                                        
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .padding()
                                }
                                Text("You will add: \(computedAmount, specifier: "%.2f") every \(selectedNumber) \(selectedUnit)")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .padding(.bottom)
                            }
                            .onChange(of: participants) { _ in
                                updateComputedAmount()}
                            .onTapGesture {
                                isFriendsInputFocused = false
                                newParticipant = ""
                            }
                            
                            if isFriendsInputFocused && !filteredFriends.isEmpty{
                                //                            if true {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: screenWidth - 50, height: 210) // Set the desired width and height
                                        .foregroundColor(.white)
                                        .shadow(radius: 5)
                                        .offset(y: -210)
                                    List(filteredFriends, id: \.id) { friend in
                                        Text(friend.name)
                                            .fontWeight(participants.contains { $0.name == friend.name } ? .regular : .semibold)
                                            .foregroundColor(participants.contains { $0.name == friend.name } ? .gray : .black)
                                        //                                            .background(participants.contains { $0.name == friend.name } ? Color.gray : Color.white)
                                            .onTapGesture {
                                                newParticipant = friend.name
//                                                addParticipantIfNotExists(Participant(id: UUID(), name: friend.name, colour: financeModel.profileColors[colorIndex]))
                                                colorIndex += 1
                                                //                                                participants.insert(, at: 0) : none }
                                                //                                                participants.append(Participant(id: UUID(), name: friend.name, colour: Color(hex: "FF5733")))
//                                                newParticipant = ""
                                            }
                                    }
                                    .frame(height: 200)
                                    .padding(.horizontal)
                                    .listStyle(.inset)
                                    .cornerRadius(10)
                                    .offset(y: -210)
                                } // Adjust this value based on your layout
                            }
                            
                        }
                        .frame(width: screenWidth - 28, height: 86)
                        .padding(.horizontal, 14)
                        .padding(.top, 63)
                        .padding(.vertical, 10)
                        .padding(.bottom)
                        
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        
                        ZStack (alignment: .center) {
                            Button(action:{
                                financeModel.modifyGroup(oldGroup: group, newGroup:
                                    Group(name: fundName, creationDate: group.creationDate, startDate: formatDateToString(date: startDate),
                                          endDate: formatDateToString(date: endDate), period: (selectedNumber, toChar(period:selectedUnit)), totalAmount: Double(totalAmount)!, currentAmount: group.currentAmount, contributionAmount: computedAmount, contributionHistory: group.contributionHistory, participants: participants))
                                
//                                    financeModel.deleteFund(groupName: group.name)
                                dismiss()
//                                    print(financeModel.groups)
                            }) {
                                Text("Modify Group")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(!fundName.isEmpty && !totalAmount.isEmpty && error[0].isEmpty && error[1].isEmpty ? Color.green : Color.green.opacity(0.5))
                                    .cornerRadius(10)
                            }
                            .padding(10)
                            .disabled(fundName.isEmpty || totalAmount.isEmpty || !error[0].isEmpty || !error[1].isEmpty)
                            
                        }
                    }
                    .frame(minHeight: geometry.size.height)
                }
                .navigationTitle("New shared fund")
            }
        }.onAppear{
            startDate = convertToDate(from: group.startDate)
            endDate = convertToDate(from: group.endDate)
            totalAmount = String(group.totalAmount)
            fundName = group.name
            let unit =  String(group.period.1)
            if unit == "D"{selectedUnit = "Day"}
            if unit == "W"{selectedUnit = "Week"}
            if unit == "M"{selectedUnit = "Month"}
            if unit == "Y"{selectedUnit = "Year"}
            selectedNumber = group.period.0
            participants = group.participants
        
        }
    }
}
    func formatDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        return dateFormatter.string(from: date)
    }
    
    func convertToDate(from dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
//        dateFormatter.locale = Locale(identifier: "it_IT")
//        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        if let date = dateFormatter.date(from: dateString) {
            return date
        } else {
            print("Invalid date string: \(dateString), returning current date as fallback")
            return Date() // Fallback to the current date
        }
    }
    func addParticipantIfNotExists(_ participant: Participant) {
        if !participants.contains(where: { $0.name.lowercased() == participant.name.lowercased() }) {
            participants.insert(participant, at: 1)
        }
    }
    
    func updateComputedAmount() {
        guard let totalAmountDouble = Double(totalAmount) else {
            if totalAmount.isEmpty {
                error[1] = ""
            } else {
                error[1] = "Invalid character"
            }
            let totalAmountDouble  = Double(0)
            computedAmount = calculateRecurringAmount(totalAmount: totalAmountDouble, startDate: startDate, endDate: endDate, selectedNumber: selectedNumber + 1, selectedUnit: selectedUnit, partNumb: participants.count)
            return
        }
        if totalAmountDouble <= 0 {
            error[1] = "Amount must be a greater than 0"
            let totalAmountDouble  = Double(0)
            computedAmount = calculateRecurringAmount(totalAmount: totalAmountDouble, startDate: startDate, endDate: endDate, selectedNumber: selectedNumber + 1, selectedUnit: selectedUnit, partNumb: participants.count)
            return
        }

        error[1] = ""
        computedAmount = calculateRecurringAmount(totalAmount: totalAmountDouble, startDate: startDate, endDate: endDate, selectedNumber: selectedNumber + 1, selectedUnit: selectedUnit, partNumb: participants.count)
    }
    func toChar(period:String)->Character{
        if period == "Day" || period == "Days"{
            return "D"
        }
        if period == "Week" || period == "Weeks"{
            return "W"
        }
        if period == "Month" || period == "Months"{
            return "M"
        }
        else {return "Y"}
    }
    func checkFundName() {
        if !fundName.isEmpty {
            error[0] = ""
        }
        
    }
    
    
    func createGroup(){
        if !totalAmount.isEmpty && !fundName.isEmpty && error[0].isEmpty && error[1].isEmpty {
            let amountD = Double(totalAmount)!
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/YY"
            
            
            let newGroup = Group(
                id:UUID(),
                name: fundName,
                creationDate: formatter.string(from: Date()),
                startDate: formatter.string(from:startDate),
                endDate: formatter.string(from: endDate),
                period: (selectedNumber, selectedUnit[selectedUnit.startIndex]),
                totalAmount: amountD,
                currentAmount: 0.0,
                contributionAmount: calculateRecurringAmount(totalAmount: Double(totalAmount)!, startDate: startDate, endDate: endDate, selectedNumber: selectedNumber, selectedUnit: selectedUnit, partNumb: participants.count),
                contributionHistory: [],
                participants: participants
            )
    //        var updatedGroup = newGroup
    //        updatedGroup.contributionHistory = generateContributionHistory(for: newGroup)
            print("group \(newGroup)")
            financeModel.addGroup(newGroup)
            dismiss()
        } else {
            if fundName.isEmpty {
                error[0] = "Missing"
            }
            if totalAmount.isEmpty {
               error[1] = "Missing"
            }
            
        }
        
        
        
    }
}

struct ModifyGroupViewPreview: PreviewProvider {
    static var previews: some View {
        ModifyGroupView(financeModel: FinanceViewModel(),
                        group: .constant(Group(name: "boat", creationDate: "21/05/24", startDate: "21/10/24", endDate: "21/05/26", period: (20,"M"), totalAmount: 5455, currentAmount: 340, contributionAmount: 50, contributionHistory: [], participants:
                    [Participant(name: "Mario", colour: .red),
                     Participant(name: "Luigi", colour: .green)
                    ])), editMode: .constant(true)
//                        , editMode:.constant(true)
        )
    }
}


