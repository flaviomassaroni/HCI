import Foundation
import SwiftUI

struct Group: Identifiable {
    let id: UUID
    let name: String
    let startDate: String
    let endDate: String
    let period: (Int, Character)
    let totalAmount: Double
    let currentAmount: Double
    let contributionAmount: Double
    var contributionHistory: [Contribution]
    var participants: [Participant]
    let creationDate: String


    var startDateAsDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter.date(from: startDate)
    }

    var endDateAsDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter.date(from: endDate)
    }

    // Ensure that all initializers are defined explicitly.
    init(id: UUID = UUID(), name: String, creationDate: String, startDate: String, endDate: String, period: (Int, Character), totalAmount: Double, currentAmount: Double,contributionAmount: Double, contributionHistory: [Contribution], participants: [Participant]) {
        self.id = id
        self.name = name
        self.creationDate = creationDate
        self.startDate = startDate
        self.endDate = endDate
        self.period = period
        self.totalAmount = totalAmount
        self.currentAmount = currentAmount
        self.contributionHistory = contributionHistory
        self.participants = participants
        self.contributionAmount = contributionAmount
    }
}


