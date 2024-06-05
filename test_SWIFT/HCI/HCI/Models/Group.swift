// Models/Group.swift
import Foundation

struct Group: Identifiable {
    var id = UUID()
    var name: String
    var startDate: String
    var endDate: String
    var period: String
    var totalAmount: Double
    var currentAmount: Double
    var contributionHistory: [(String, Double)]


}
