import Foundation
import SwiftUI

class FinanceViewModel: ObservableObject {
    @Published var balance: Double = 1927.56
    @Published var transactions: [Transaction] = [
        Transaction(id: UUID(), name: "Patches", date: "25/05/24", time: "09:34", amount: 3.20, category: "Health", location: "Farmacia Igea"),
        Transaction(id: UUID(), name: "Coffee", date: "25/05/24", time: "09:34", amount: 1.10, category: "Food", location: "Bar Buongiorno"),
        Transaction(id: UUID(), name: "Groceries", date: "25/05/24", time: "09:34", amount: 24.60, category: "Groceries", location: "Eurospin"),
        Transaction(id: UUID(), name: "Headphones", date: "25/05/24", time: "09:34", amount: 199.90, category: "Electronics", location: "Mediaworld Roma"),
        Transaction(id: UUID(), name: "Pet Food", date: "16/05/24", time: "09:34", amount: 6.30, category: "Pet", location: "L'Arca"),
        Transaction(id: UUID(), name: "Groceries", date: "25/05/24", time: "09:34", amount: 57.20, category: "Groceries", location: "Conad"),
        Transaction(id: UUID(), name: "Enterogermina", date: "25/05/24", time: "09:34", amount: 15.70, category: "Health", location: "Farmacia Comunale"),
        Transaction(id: UUID(), name: "Oki", date: "25/05/24", time: "09:34", amount: 12.30, category: "Health", location: "Se Non Muori Ritorni")
    ]
    
    @Published var groups: [Group] = [
        Group(id: UUID(), name: "Boat", startDate: "23/05/24", endDate: "30/06/25", period: (1,"M"), totalAmount: 6000, currentAmount: 550, contributionHistory: [
            Contribution(owner: Participant(name:"Andrea Salinetti", colour: Color(hex: "FF5733")), date: "01/05/24", amount: 100.0),
            Contribution(owner: Participant(name:"Flavio Massaroni", colour: Color(hex: "3357FF")), date: "01/05/24", amount: 100.0),
            Contribution(owner:Participant(name:"Leonardo Scappatura", colour: Color(hex: "33FF57")), date: "01/05/24", amount: 100.0),
            Contribution(owner: Participant(name:"Andrea Salinetti", colour: Color(hex: "FF5733")), date: "01/05/24", amount: 100.0)],
              participants: [
            Participant(name:"Andrea Salinetti", colour: Color(hex: "FF5733")),
            Participant(name:"Leonardo Scappatura", colour: Color(hex: "33FF57")),
            Participant(name:"Flavio Massaroni", colour: Color(hex: "3357FF"))
        ]),
        Group(id: UUID(), name: "Spain Holidays", startDate: "23/05/24", endDate: "30/06/25", period: (2,"M"), totalAmount: 2000, currentAmount: 850, contributionHistory: [
            Contribution(owner: Participant(name:"Andrea Salinetti", colour: Color(hex: "FF5733")), date: "01/05/24", amount: 100.0),
            Contribution(owner: Participant(name:"Flavio Massaroni", colour: Color(hex: "3357FF")), date: "01/05/24", amount: 100.0),
            Contribution(owner:Participant(name:"Leonardo Scappatura", colour: Color(hex: "33FF57")), date: "01/05/24", amount: 100.0),
            Contribution(owner: Participant(name:"Andrea Salinetti", colour: Color(hex: "FF5733")), date: "01/05/24", amount: 100.0)],
              participants: [
            Participant(name:"Andrea Salinetti", colour: Color(hex: "FF5733")),
            Participant(name:"Leonardo Scappatura", colour: Color(hex: "33FF57")),
            Participant(name:"Flavio Massaroni", colour: Color(hex: "3357FF"))
        ]),
        Group(id: UUID(), name: "Graduation Present", startDate: "23/05/24", endDate: "30/06/25", period: (1, "W"), totalAmount: 300, currentAmount: 250, contributionHistory: [
            Contribution(owner: Participant(name:"Andrea Salinetti", colour: Color(hex: "FF5733")), date: "01/05/24", amount: 100.0),
            Contribution(owner: Participant(name:"Flavio Massaroni", colour: Color(hex: "3357FF")), date: "01/05/24", amount: 100.0),
            Contribution(owner:Participant(name:"Leonardo Scappatura", colour: Color(hex: "33FF57")), date: "01/05/24", amount: 100.0),
            Contribution(owner: Participant(name:"Andrea Salinetti", colour: Color(hex: "FF5733")), date: "01/05/24", amount: 100.0)],
              participants: [
            Participant(name:"Andrea Salinetti", colour: Color(hex: "FF5733")),
            Participant(name:"Leonardo Scappatura", colour: Color(hex: "33FF57")),
            Participant(name:"Flavio Massaroni", colour: Color(hex: "3357FF"))
        ]),
    ]
    
    func addGroup(_ group:Group){
        print(group)
        groups.append(group)
    }
}

struct Participant: Identifiable, Hashable{
    var id = UUID()
    var name: String
    var colour: Color
}
