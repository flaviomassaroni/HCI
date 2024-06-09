import Foundation

struct Friend: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var mail: String
    var accountId = UUID()
}
