import Foundation

class FriendsModel: ObservableObject {
    @Published var friends: [Friend] = [
        Friend(id: UUID(), name: "Leonardo", mail: "leo@gmail.com", accountId: UUID()),
        Friend(id: UUID(), name: "Lorenzo", mail: "lore@gmail.com", accountId: UUID()),
        Friend(id: UUID(), name: "Flavio", mail: "flavio@gmail.com", accountId: UUID()),
        Friend(id: UUID(), name: "Andrea", mail: "andre@gmail.com", accountId: UUID()),
        Friend(id: UUID(), name: "Filippo", mail: "filippo@gmail.com", accountId: UUID()),
        Friend(id: UUID(), name: "Giulia", mail: "giulia@gmail.com", accountId: UUID())
    ]
}
