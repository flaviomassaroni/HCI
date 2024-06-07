import Foundation
import SwiftUI

func addPeriodToDate(dateString: String, period: String) -> String? {
    // Create a date formatter to parse the input date string
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yy"
    
    // Parse the input date string
    guard let date = dateFormatter.date(from: dateString) else {
        return nil // Return nil if the input date string is invalid
    }
    
    // Extract the number part and the unit part from the period string
    guard let periodValue = Int(period.dropLast()), // Extract number
          let periodUnit = period.last else { // Extract unit
        return nil // Return nil if the period string is invalid
    }
    
    // Calculate the new date based on the period unit
    var newDate: Date?
    switch periodUnit {
    case "D":
        newDate = Calendar.current.date(byAdding: .day, value: periodValue, to: date)
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

let profileColors: [Color] = [
    Color(hex: "FF5733"), // Vibrant Orange
    Color(hex: "33FF57"), // Bright Green
    Color(hex: "3357FF"), // Bright Blue
    Color(hex: "FF33A6"), // Hot Pink
    Color(hex: "A633FF"), // Purple
    Color(hex: "33FFF0"), // Aqua
    Color(hex: "FF8C33"), // Warm Orange
    Color(hex: "FFC733"), // Golden Yellow
    Color(hex: "8DFF33"), // Lime Green
    Color(hex: "FF3333"), // Bright Red
    Color(hex: "33B8FF"), // Sky Blue
    Color(hex: "FF33D4"), // Magenta
    Color(hex: "B833FF"), // Violet
    Color(hex: "33FFA2"), // Mint Green
    Color(hex: "FF8633"), // Coral
    Color(hex: "FFE733"), // Sunflower Yellow
    Color(hex: "8CFF33"), // Chartreuse
    Color(hex: "33D4FF"), // Cyan
    Color(hex: "FF3384"), // Fuchsia
    Color(hex: "6F33FF")  // Indigo
]

