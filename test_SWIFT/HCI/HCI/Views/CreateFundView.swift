// Views/CreateFundView.swift
import SwiftUI
import Foundation

struct CreateFundView: View {

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
    @State private var newFriend: String = ""
    @State private var participants: [Participant] = []
    
    
    @State var screenWidth: CGFloat = UIScreen.main.bounds.width
    @State var screenHeight: CGFloat = UIScreen.main.bounds.height
    
    let numbers = Array(1...30)
    let unitOptions = ["Day", "Week", "Month", "Year"]
    var units: [String] {
        selectedNumber > 1 ? unitOptions.map{$0 + "s"}: unitOptions
    }
    
    var body: some View {
        VStack (alignment: .center, spacing: 10){
            ZStack{
                RoundedRectangle(cornerRadius: 14)
                    .foregroundColor(Color.blue)
                    
                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 100, height: 5)
                        .padding(.top, 5)
                        .foregroundColor(Color.gray)
                    Text("Create New Fund")
                        .font(.largeTitle)
                        .padding()
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                }
                
            }
            .frame(width: screenWidth, height: 110)
            .padding(.top, -10)
            
            GeometryReader { geometry in
                ScrollView {
                    VStack (spacing:10) {
                        //          Fund Name
                        ZStack {
                            RoundedRectangle(cornerRadius: 14)
                                .foregroundColor(Color.white)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 3)
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Fund Name")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .padding(.leading)
                                    .foregroundColor(Color.black)
                                
                                ZStack(alignment: .trailing) {
                                    TextField("Fuerteventura's Trip", text: $fundName)
                                        .padding()
                                        .background(Color(.systemGray6))
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                    
                                    Button(action: {
                                        fundName = ""
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 10)
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            .padding(.horizontal, 5)
                            .padding(.vertical, 10)
                        }
                        .frame(width: screenWidth - 28, height: 86)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        
                        //          Amount
                        ZStack {
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
                                            .background(Color(.systemGray6))
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
                            }
                            .padding(.horizontal, 5)
                            .padding(.vertical, 10)
                        }
                        .frame(width: screenWidth - 28, height: 86)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        
                        
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
                                            displayedComponents: .date
                                        )
                                        .datePickerStyle(.compact)
                                        .labelsHidden()
                                        .padding()
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
                                    TextField("Enter your friend's name", text: $newFriend)
                                        .padding()
                                        .background(Color(.systemGray6))
                                        .cornerRadius(10)
                                    
                                    Button(action: {
                                        if !newFriend.isEmpty {
                                            participants.append(Participant(id: UUID(), name: newFriend, colour: Color(hex: "FF5733")))
                                            newFriend = ""
                                        }
                                    }) {
                                        Image(systemName: "plus")
                                            .padding()
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                    }
                                    
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
                                    .padding()
                                }
                                Text("You will put: \(computedAmount, specifier: "%.2f") every \(selectedNumber) \(selectedUnit)")
                                    .font(.body)
                                    .fontWeight(.semibold)
//                                    .padding(.top, 10)
                                
                                
                                Button(action: createGroup) {
                                    Text("Create Fund")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.green)
                                        .cornerRadius(10)
                                }
                                .padding(10)
                            }.onChange(of: participants) { _ in
                                updateComputedAmount()}
                            
                        }
                        .frame(width: screenWidth - 28, height: 86)
                        .padding(.horizontal, 14)
                        .padding(.top, 90)
                        .padding(.vertical, 10)
                        
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    .frame(minHeight: geometry.size.height)
                }
                .navigationTitle("New shared fund")
            }
        }
    }
    
    func updateComputedAmount() {
        guard let totalAmountDouble = Double(totalAmount) else {
            computedAmount = 0.0
            return
        }
        
        computedAmount = calculateRecurringAmount(totalAmount: totalAmountDouble, startDate: startDate, endDate: endDate, selectedNumber: selectedNumber, selectedUnit: selectedUnit, partNumb: participants.count)
    }
    
    func createGroup(){
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
        print("group \(newGroup)")
        financeModel.addGroup(newGroup)
        dismiss()
        
    }
}

struct CreateFundView_Previews: PreviewProvider {
    static var previews: some View {
        CreateFundView(financeModel: FinanceViewModel())
    }
}


func calculateRecurringAmount(totalAmount: Double, startDate: Date, endDate: Date, selectedNumber: Int, selectedUnit: String, partNumb: Int) -> Double {
    var divideBy = 1
    if partNumb != 0 {divideBy = partNumb}
    // Calculate the total number of days between start and end date
    let calendar = Calendar.current
    guard let totalDays = calendar.dateComponents([.day], from: startDate, to: endDate).day else {
        return totalAmount/Double(divideBy)
    }

    // Calculate the number of recurrences based on the frequency
    var numberOfRecurrences: Int?
    switch selectedUnit {
    case "Day", "Days":
        numberOfRecurrences = totalDays / selectedNumber
    case "Week", "Weeks":
        numberOfRecurrences = totalDays / (7 * selectedNumber)
    case "Month", "Months":
        numberOfRecurrences = calendar.dateComponents([.month], from: startDate, to: endDate).month! / selectedNumber
    case "Year", "Years":
        numberOfRecurrences = calendar.dateComponents([.year], from: startDate, to: endDate).year! / selectedNumber
    default:
        return totalAmount/Double(divideBy)
    }

    guard let recurrences = numberOfRecurrences, recurrences > 0 else {
        return totalAmount/Double(divideBy)
    }

    // Calculate the amount to be put on each recurrence
    let amountPerRecurrence = Double(totalAmount) / Double(recurrences + 1)
    return amountPerRecurrence/Double(divideBy)
}
