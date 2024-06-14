import Foundation
import SwiftUI

struct Category: Identifiable{
var id = UUID()
var name: String
var colour: Color
var iconName: String
}

var healthCategory = Category(name: "Health & Care", colour: Color(hex:"00A79D"), iconName: "health")
var diningCategory = Category(name: "Dining", colour: Color(hex:"7F7CFF"), iconName: "dining")
var groceriesCategory = Category(name: "Groceries", colour: Color(hex:"FFB800"), iconName: "groceries")
var petsCategory = Category(name: "Pets", colour: Color(hex:"B31DCC"), iconName: "pets")
var housingCategory = Category(name: "Housing", colour: Color(hex:"18A0FB"), iconName: "house")
var technologyCategory = Category(name: "Technology", colour: Color(hex:"FF7A00"), iconName: "technology")
var transportationCategory = Category(name: "Transportation", colour: Color(hex:"FB9DCB"), iconName: "transportation")
var entertainmentCategory = Category(name: "Entertainment", colour: Color(hex:"8ECB8D"), iconName: "entertainment")
var subscriptionsCategory = Category(name: "Subscriptions", colour: Color(hex:"9B675C"), iconName: "subscriptions")
var educationCategory = Category(name: "Gifts and Donations", colour: Color(hex:"FD3496"), iconName: "gift")
var moneyTransfersCategory = Category(name: "Money Transfers", colour: Color(hex:"EFF187"), iconName: "moneyTransfers")
var carpentryCategory = Category(name: "Carpentry", colour: Color(hex:"C99D5B"), iconName: "hammer")


class FinanceViewModel: ObservableObject {
    
    @Published var balance: Double = 1927.56
    @Published var transactions: [Transaction] = [
        Transaction(id: UUID(), name: "Patches", date: "25/05/24", time: "09:34", amount: 3.20, category: healthCategory, location: "Farmacia Igea"),
        Transaction(id: UUID(), name: "Coffee", date: "25/05/24", time: "09:34", amount: 1.10, category: diningCategory, location: "Bar Buongiorno"),
        Transaction(id: UUID(), name: "Groceries", date: "25/05/24", time: "09:34", amount: 24.60, category: groceriesCategory, location: "Eurospin"),
        Transaction(id: UUID(), name: "Headphones", date: "25/05/24", time: "09:34", amount: 199.90, category: technologyCategory, location: "Mediaworld Roma"),
        Transaction(id: UUID(), name: "Pet Food", date: "16/05/24", time: "09:34", amount: 6.30, category: petsCategory, location: "L'Arca"),
        Transaction(id: UUID(), name: "Groceries", date: "25/05/24", time: "09:34", amount: 57.20, category: groceriesCategory, location: "Conad"),
        Transaction(id: UUID(), name: "Enterogermina", date: "25/05/24", time: "09:34", amount: 15.70, category: healthCategory, location: "Farmacia Comunale"),
        Transaction(id: UUID(), name: "Oki", date: "25/05/24", time: "09:34", amount: 12.30, category: healthCategory, location: "Se Non Muori Ritorni")
    ]
    
    @Published var groups: [Group] = [
        Group(id: UUID(), name: "Boat", creationDate: "23/05/24", startDate: "23/05/24", endDate: "30/06/25", period: (1,"M"), totalAmount: 6000, currentAmount: 550, contributionAmount: 100, contributionHistory: [
            Contribution(owner: Participant(name:"Andrea Salinetti", colour: Color(hex: "FF5733")), date: "01/05/24", amount: 100.0, paid: false),
            Contribution(owner: Participant(name:"You", colour: Color(hex: "000000")), date: "01/05/24", amount: 100.0, paid: false),
            Contribution(owner: Participant(name:"Flavio Massaroni", colour: Color(hex: "3357FF")), date: "01/05/24", amount: 100.0, paid: false),
            Contribution(owner:Participant(name:"Leonardo Scappatura", colour: Color(hex: "33FF57")), date: "01/05/24", amount: 100.0, paid: false),
            Contribution(owner: Participant(name:"Andrea Salinetti", colour: Color(hex: "FF5733")), date: "01/05/24", amount: 100.0, paid: false)],
              participants: [
            Participant(name:"You", colour: Color(hex: "000000")),
            Participant(name:"Andrea Salinetti", colour: Color(hex: "FF5733")),
            Participant(name:"Leonardo Scappatura", colour: Color(hex: "33FF57")),
            Participant(name:"Flavio Massaroni", colour: Color(hex: "3357FF"))
        ]),
        Group(id: UUID(), name: "Spain Holidays", creationDate: "20/05/24", startDate: "23/05/24", endDate: "30/06/25", period: (2,"M"), totalAmount: 2000, currentAmount: 850,contributionAmount: 100, contributionHistory: [
            Contribution(owner: Participant(name:"Andrea Salinetti", colour: Color(hex: "FF5733")), date: "01/05/24", amount: 100.0, paid: false),
            Contribution(owner: Participant(name:"Flavio Massaroni", colour: Color(hex: "3357FF")), date: "01/05/24", amount: 100.0, paid: false),
            Contribution(owner:Participant(name:"Leonardo Scappatura", colour: Color(hex: "33FF57")), date: "01/05/24", amount: 100.0, paid: false),
            Contribution(owner: Participant(name:"Andrea Salinetti", colour: Color(hex: "FF5733")), date: "01/05/24", amount: 100.0, paid: false)],
              participants: [
            Participant(name:"You", colour: Color(hex: "FFA533")),
            Participant(name:"Andrea Salinetti", colour: Color(hex: "FF5733")),
            Participant(name:"Leonardo Scappatura", colour: Color(hex: "33FF57")),
            Participant(name:"Flavio Massaroni", colour: Color(hex: "3357FF"))
        ]),
        Group(id: UUID(), name: "Graduation Present", creationDate: "23/05/24", startDate: "23/05/24", endDate: "30/06/25", period: (1, "W"), totalAmount: 300, currentAmount: 250,contributionAmount: 100, contributionHistory: [
            Contribution(owner: Participant(name:"Andrea Salinetti", colour: Color(hex: "FF5733")), date: "01/05/24", amount: 100.0, paid: false),
            Contribution(owner: Participant(name:"Flavio Massaroni", colour: Color(hex: "3357FF")), date: "01/05/24", amount: 100.0, paid: false),
            Contribution(owner:Participant(name:"Leonardo Scappatura", colour: Color(hex: "33FF57")), date: "01/05/24", amount: 100.0, paid: false),
            Contribution(owner: Participant(name:"Andrea Salinetti", colour: Color(hex: "FF5733")), date: "01/05/24", amount: 100.0, paid: false)],
              participants: [
            Participant(name:"You", colour: Color(hex: "FFA533")),
            Participant(name:"Andrea Salinetti", colour: Color(hex: "FF5733")),
            Participant(name:"Leonardo Scappatura", colour: Color(hex: "33FF57")),
            Participant(name:"Flavio Massaroni", colour: Color(hex: "3357FF"))
        ]),
    ]
    
    
    func addGroup(_ group:Group){
        print(group)
        groups.append(group)
    }
    
    func payContributions(for groupID: UUID, checkedContributions: Set<UUID>) {
        guard let groupIndex = groups.firstIndex(where: { $0.id == groupID }) else {
            return
        }
        
        
        balance -= groups[groupIndex].payContributions(checkedContributions: checkedContributions)
        
        // Notify SwiftUI about the state change
        objectWillChange.send()
    }
    
    
    
    func editCategory(newCategory: Category, transaction:Transaction){
        for index in transactions.indices {
            if transactions[index].id == transaction.id{
                print("old: ", transactions[index].category)
                transactions[index].category = newCategory
                print("new: ", transactions[index].category)
            }
        }
    }
    let profileColors: [Color] = [
        Color.black,           // Black
        Color(hex: "FFD700"),  // Gold
        Color(hex: "FF1493"),  // Deep Pink
        Color(hex: "FF7F11"),  // Bright Orange
        Color(hex: "1AAB9B"),  // Turquoise
        Color(hex: "FF66C4"),  // Pink
        Color(hex: "8B008B"),  // Dark Magenta
        Color(hex: "5F9EA0"),  // Cadet Blue
        Color(hex: "FF4500"),  // Orange Red
        Color(hex: "708090"),  // Slate Gray
        Color(hex: "CD853F"),  // Peru
        Color(hex: "483D8B"),  // Dark Slate Blue
        Color(hex: "008080"),  // Teal
        Color(hex: "800080"),  // Purple
        Color(hex: "008B8B"),  // Dark Cyan
        Color(hex: "FF6347"),  // Tomato
        Color(hex: "4B0082"),  // Indigo
        Color(hex: "7FFFD4"),  // Aquamarine
        Color(hex: "00A572")   // Emerald Green
    ]


}

struct Participant: Identifiable, Hashable{
    var id = UUID()
    var name: String
    var colour: Color
}

import Foundation
import SwiftUI

func addPeriodToDate(dateString: String, period: (Int, Character)) -> String? {
    // Create a date formatter to parse the input date string
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yy"
    
    // Parse the input date string
    guard let date = dateFormatter.date(from: dateString) else {
        return nil // Return nil if the input date string is invalid
    }
    
    let periodValue = period.0
    let periodUnit = period.1

    // Example validation: Ensure periodValue is greater than zero
    guard periodValue > 0 else {
        // Handle invalid periodValue
        print("Invalid periodValue")
        return nil
    }
    
    let validUnits: Set<Character> = ["D", "W", "M", "Y"]
    guard validUnits.contains(periodUnit) else {
        // Handle invalid periodUnit
        print("Invalid periodUnit")
        return nil
    }
    
    // Calculate the new date based on the period unit
    var newDate: Date?
    switch periodUnit {
    case "D":
        newDate = Calendar.current.date(byAdding: .day, value: periodValue, to: date)
    case "W":
        newDate = Calendar.current.date(byAdding: .weekOfYear, value: periodValue, to: date)
    case "M":
        newDate = Calendar.current.date(byAdding: .month, value: periodValue, to: date)
    case "Y":
        newDate = Calendar.current.date(byAdding: .year, value: periodValue, to: date)
    default:
        break
    }
    
    // Format the new date back to the string with the same format
    if let newDate = newDate {
        return dateFormatter.string(from: newDate)
    } else {
        return nil // Return nil if the calculation fails
    }
}



