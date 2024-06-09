// Models/Group.swift
import Foundation
import SwiftUI

struct Group: Identifiable {
    var id = UUID()
    var name: String
    var startDate: String
    var endDate: String
    var period: (Int, Character)
    var totalAmount: Double
    var currentAmount: Double
    var contributionHistory: [Contribution]
    var participants: [Participant]
}
