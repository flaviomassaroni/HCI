import Foundation

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
        Group(id: UUID(), name: "Boat", startDate: "23/05/24", endDate: "30/06/25", period: "1M", totalAmount: 6000, currentAmount: 550, contributionHistory: [
            ("01/05/24", 100.0),
            ("15/05/24", 150.0),
            ("01/06/24", 200.0),
            ("15/06/24", 100.0)
        ]),
        Group(id: UUID(), name: "Spain Holidays", startDate: "23/05/24", endDate: "30/06/25", period: "1M", totalAmount: 2000, currentAmount: 850, contributionHistory: [
            ("01/05/24", 200.0),
            ("15/05/24", 300.0),
            ("01/06/24", 150.0),
            ("15/06/24", 200.0)
        ]),
        Group(id: UUID(), name: "Graduation Present", startDate: "23/05/24", endDate: "30/06/25", period: "1M", totalAmount: 300, currentAmount: 250, contributionHistory: [
            ("01/05/24", 50.0),
            ("15/05/24", 100.0),
            ("01/06/24", 50.0),
            ("15/06/24", 50.0)
        ])
    ]
}
