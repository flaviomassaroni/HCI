// ViewModels/FinanceViewModel.swift
import Foundation

class FinanceViewModel: ObservableObject {
    @Published var balance: Double = 1927.56
    @Published var transactions: [Transaction] = [
        Transaction(name: "Patches", date: "25/05/24", time: "09:34", amount: 3.20, category: "Health", location: "Farmacia Igea"),
        Transaction(name: "Coffee", date: "25/05/24", time: "09:34", amount: 1.10, category: "Food", location: "Bar Buongiorno"),
        Transaction(name: "Groceries", date: "25/05/24", time: "09:34", amount: 24.60, category: "Groceries", location: "Eurospin"),
        Transaction(name: "Headphones", date: "25/05/24", time: "09:34", amount: 199.90, category: "Electronics", location: "Mediaworld Roma"),
        Transaction(name: "Pet Food", date: "16/05/24", time: "09:34", amount: 6.30, category: "Pet", location: "L'Arca"),
        Transaction(name: "Groceries", date: "25/05/24", time: "09:34", amount: 57.20, category: "Groceries", location: "Conad"),
        Transaction(name: "Enterogermina", date: "25/05/24", time: "09:34", amount: 15.70, category: "Health", location: "Farmacia Comunale"),
        Transaction(name: "Oki", date: "25/05/24", time: "09:34", amount: 12.30, category: "Health", location: "Se Non Muori Ritorni")
    ]
    
    @Published var groups: [Group] = [
        Group(name: "Boat", startDate: "23/05/24", endDate: "30/06/25", totalAmount: 6000, currentAmount: 550),
        Group(name: "Spain Holidays", startDate: "23/05/24", endDate: "30/06/25", totalAmount: 2000, currentAmount: 850),
        Group(name: "Graduation Present", startDate: "23/05/24", endDate: "30/06/25", totalAmount: 300, currentAmount: 250)
    ]
}
