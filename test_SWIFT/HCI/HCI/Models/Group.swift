import Foundation
import SwiftUI

struct Group: Identifiable {
    var id: UUID
    var name: String
    var startDate: String
    var endDate: String
    var period: (Int, Character)
    var totalAmount: Double
    var currentAmount: Double
    var contributionAmount: Double
    var contributionHistory: [Contribution]
    var participants: [Participant]
    var creationDate: String
    
    mutating func payContributions(checkedContributions: Set<UUID>)->Double {
        var paidAmount = 0.0
        for index in self.contributionHistory.indices {
//            print("checking contribution: \(self.contributionHistory[index].id)")
            if checkedContributions.contains(self.contributionHistory[index].id) {
                self.contributionHistory[index].paid = true
                self.currentAmount += self.contributionHistory[index].amount
//                print("contribution: \(self.contributionHistory[index])")
//                print("group amount: \(self.currentAmount)")
                paidAmount += self.contributionHistory[index].amount
            }
        }
        return paidAmount
    }


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
        self.participants = participants
        self.contributionAmount = contributionAmount
        self.contributionHistory = []
        self.contributionHistory = generateContributionHistory(for: self)
    }

    mutating func cleanHistory(){
        self.contributionHistory = []
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
        numberOfRecurrences = calendar.dateComponents([.weekOfYear], from: startDate, to: endDate).weekOfYear! / selectedNumber
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

// Function to add the period to a given date
func addPeriodToDate(date: Date, period: (Int, Character)) -> Date? {
    var dateComponent = DateComponents()
    
    switch period.1 {
    case "D": // Days
        dateComponent.day = period.0
    case "W": // Weeks
        dateComponent.weekOfYear = period.0
    case "M": // Months
        dateComponent.month = period.0
    case "Y": // Years
        dateComponent.year = period.0
    default:
        return nil
    }
    
    return Calendar.current.date(byAdding: dateComponent, to: date)
}

// Function to convert a date string to a Date object
func dateFromString(dateString: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yy"
    return formatter.date(from: dateString)
}

// Function to convert a Date object to a date string
func stringFromDate(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yy"
    return formatter.string(from: date)
}

// Function to generate the contribution history
func generateContributionHistory(for group: Group) -> [Contribution] {
    guard let startDate = dateFromString(dateString: group.startDate),
          let endDate = dateFromString(dateString: group.endDate) else {
        return []
    }
    
    var currentDate = startDate
    var contributions = [Contribution]()
    
    while currentDate <= endDate {
        for participant in group.participants {
            let contribution = Contribution(
                owner: participant,
                date: stringFromDate(date: currentDate),
                amount: group.contributionAmount,
                paid: false
            )
            contributions.append(contribution)
        }
        if let nextDate = addPeriodToDate(date: currentDate, period: group.period) {
            currentDate = nextDate
        } else {
            break
        }
    }
    return contributions
}

func generateContributionHistoryParticipant(participant: Participant, startDate: String, endDate: String, amount: Double, period: (Int, Character)) -> [Contribution] {
    guard let startDate = dateFromString(dateString: startDate),
          let endDate = dateFromString(dateString: endDate) else {
        return []
    }
    
    var currentDate = startDate
    var contributions = [Contribution]()
    
    while currentDate <= endDate {
        let contribution = Contribution(
            owner: participant,
            date: stringFromDate(date: currentDate),
            amount: amount,
            paid: false
        )
        contributions.append(contribution)

        if let nextDate = addPeriodToDate(date: currentDate, period: period) {
            currentDate = nextDate
        } else {
            break
        }
    }
    return contributions
}





