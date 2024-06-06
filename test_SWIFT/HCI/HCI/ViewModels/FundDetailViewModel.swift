import Foundation

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
