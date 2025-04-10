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
var giftsCategory = Category(name: "Gifts and Donations", colour: Color(hex:"FD3496"), iconName: "gift")
var moneyTransfersCategory = Category(name: "Money Transfers", colour: Color(hex:"EFF187"), iconName: "moneyTransfers")
var carpentryCategory = Category(name: "Carpentry", colour: Color(hex:"C99D5B"), iconName: "hammer")
var educationCategory = Category(name: "Education", colour: Color(hex:"428364"), iconName: "education")


class FinanceViewModel: ObservableObject {
    
    @Published var balance: Double = 1927.56
    @Published var transactions: [Transaction] = [
        Transaction(id: UUID(), name: "Patches", date: "20/05/24", time: "19:34", amount: 3.20, category: healthCategory, location: "Farmacia Igea"),
        Transaction(id: UUID(), name: "Birthday Present", date: "03/04/24", time: "10:20", amount: 200.00, category: giftsCategory, location: "Rome", sign: "+"),
        Transaction(id: UUID(), name: "Groceries", date: "15/04/24", time: "12:44", amount: 24.60, category: groceriesCategory, location: "Eurospin"),
        Transaction(id: UUID(), name: "Headphones", date: "11/04/24", time: "16:22", amount: 199.90, category: technologyCategory, location: "Mediaworld Roma"),
        Transaction(id: UUID(), name: "Monthly Salary", date: "10/04/24", time: "19:22", amount: 1800.00, category: moneyTransfersCategory, location: "Milan", sign: "+"),
        Transaction(id: UUID(), name: "Pet Food", date: "10/04/24", time: "18:55", amount: 6.30, category: petsCategory, location: "L'Arca"),
        Transaction(id: UUID(), name: "Groceries", date: "06/04/24", time: "09:14", amount: 57.20, category: groceriesCategory, location: "Conad"),
        Transaction(id: UUID(), name: "Coffee", date: "12/05/24", time: "08:52", amount: 1.10, category: diningCategory, location: "Bar Buongiorno"),
        Transaction(id: UUID(), name: "Enterogermina", date: "01/04/24", time: "11:23", amount: 15.70, category: healthCategory, location: "Farmacia Comunale"),
        Transaction(id: UUID(), name: "Oki", date: "25/03/24", time: "14:34", amount: 12.30, category: healthCategory, location: "Se Non Muori Ritorni")
    ]
    
    @Published var groups: [Group] = []
    
    func modifyGroup(oldGroup: Group, newGroup: Group){
        
        var workGroup = newGroup
        workGroup.cleanHistory()
        
        for participant in newGroup.participants {
            
            var totPaid = 0.0
            for contr in oldGroup.contributionHistory {
                if contr.owner.name == participant.name && contr.paid {
                    workGroup.contributionHistory.append(contr)
                    totPaid += contr.amount
                }
            }
            let missing = (newGroup.totalAmount / Double(newGroup.participants.count)) - totPaid
            
            let cost = missing / Double(numberOfIntervals(from: newGroup.startDate, to: newGroup.endDate, withFrequency: newGroup.period)!)
            

            let generatedContrs = generateContributionHistoryParticipant(participant: participant, startDate: newGroup.startDate, endDate: newGroup.endDate, amount: cost, period: newGroup.period)
//            print("GENERATEDDDDD: \(generatedContrs)\n")
            workGroup.contributionHistory.append(contentsOf: generatedContrs)

        }
        for contr in workGroup.contributionHistory{
            if contr.owner.name == "You"{
                workGroup.yourContributionAmount = contr.amount}
        }
        
        for index in groups.indices{
            if groups[index].name == oldGroup.name{
                print("\(groups[index])\n")
                print("\(workGroup)\n")
                groups[index] = workGroup
                break
            }
        }
    }
    func yourAmountFromFinance(group: Group)->Double{
        var workGroup = group
        workGroup.cleanHistory()
        
        for participant in group.participants {
            
            var totPaid = 0.0
            for contr in group.contributionHistory {
                if contr.owner.name == participant.name && contr.paid {
                    workGroup.contributionHistory.append(contr)
                    totPaid += contr.amount
                }
            }
            let missing = (group.totalAmount / Double(group.participants.count)) - totPaid
            
            let cost = missing / Double(numberOfIntervals(from: group.startDate, to: group.endDate, withFrequency: group.period)!)
            

            let generatedContrs = generateContributionHistoryParticipant(participant: participant, startDate: group.startDate, endDate: group.endDate, amount: cost, period: group.period)
//            print("GENERATEDDDDD: \(generatedContrs)\n")
            workGroup.contributionHistory.append(contentsOf: generatedContrs)

        }
        for contr in workGroup.contributionHistory{
            if contr.owner.name == "You"{
                return contr.amount}
            
        }
        return 0.0
    }
    
    func numberOfIntervals(from startDate: String, to endDate: String, withFrequency frequency: (Int, Character)) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"

        guard let start = dateFormatter.date(from: startDate),
              let end = dateFormatter.date(from: endDate) else {
            return nil // Return nil if date formatting fails
        }

        let calendar = Calendar.current

        let frequencyUnit = frequency.1
        guard let frequencyValue = Optional(frequency.0) else {
            return nil // Return nil if frequency parsing fails
        }

        var interval: Int = 0
        switch frequencyUnit {
        case "D":
            interval = calendar.dateComponents([.day], from: start, to: end).day ?? 0
            return interval / frequencyValue
        case "W":
            interval = calendar.dateComponents([.weekOfYear], from: start, to: end).day ?? 0
            return interval / frequencyValue
        case "M":
            interval = calendar.dateComponents([.month], from: start, to: end).month ?? 0
            return interval / frequencyValue
        case "Y":
            interval = calendar.dateComponents([.year], from: start, to: end).year ?? 0
            return interval / frequencyValue
        default:
            return nil // Return nil if frequency unit is invalid
        }
    }
    
    private func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
    
    
    
    func addTransaction(name:String, amount:Double, sign:String="-")->(){

        transactions.insert(Transaction(name: name, date:currentDate(), time:currentTime(), amount:amount, category: moneyTransfersCategory, location: "Rome"),  at: 0)
    }
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
    
    func deleteFund(groupName:String){
        print("I'm deleting the group")
        var total: Double = 0
        for index in groups.indices{
//            print("groups[index].name", groups[index].name)
            if groups[index].name == groupName{
                for contribution in groups[index].contributionHistory{
                    print(contribution)
                    if contribution.paid && contribution.owner.name == "You"{
                        total += contribution.amount
                        
                    }
                }
                balance += total
                if total > 0.0{
                    transactions.insert(Transaction(name: "Refund to \(groups[index].name)", date:currentDate(), time:currentTime(), amount:total, category: moneyTransfersCategory, location: "Rome", sign: "+"),  at: 0)
                }
                    
                    groups.remove(at: index)
                }
            }
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
func currentTime()->(String){
    let currentTime = Date()
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "HH:mm"
    let formattedTime = timeFormatter.string(from: currentTime)
    return formattedTime
}

func currentDate()->(String){
    let currentDate = Date()
    let DateFormatter = DateFormatter()
    DateFormatter.dateFormat = "dd/MM/yy"
    let formattedDate = DateFormatter.string(from: currentDate)
    return formattedDate
}

