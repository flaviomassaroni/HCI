import Foundation

struct Friend: Identifiable {
    var id = UUID()
    var name: String
    var mail: String
    var accountId = UUID()
}
