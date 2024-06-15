// Models/Transaction.swift
import Foundation

struct Transaction: Identifiable {
    var id = UUID()
    var name: String
    var date: String
    var time: String
    var amount: Double
    var category: Category
    var location: String
    var sign: String = "-"
}
