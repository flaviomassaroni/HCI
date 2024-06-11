import Foundation
import SwiftUI

struct Contribution: Identifiable {
    var id = UUID()
    var owner: Participant
    var date: String
    var amount: Double
    var paid: Bool
}
