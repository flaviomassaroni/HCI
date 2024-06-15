import Foundation

class FriendsModel: ObservableObject {
    @Published var friends: [Friend] = [
        Friend(id: UUID(), name: "Leonardo", mail: "leo@mail.com"),
        Friend(id: UUID(), name: "Lorenzo", mail: "lore@mail.com"),
        Friend(id: UUID(), name: "Flavio", mail: "flavio@mail.com"),
        Friend(id: UUID(), name: "Andrea", mail: "andre@mail.com"),
        Friend(id: UUID(), name: "Filippo", mail: "filippo@mail.com"),
        Friend(id: UUID(), name: "Giulia", mail: "giulia@mail.com"),
        Friend(id: UUID(), name: "Marco", mail: "marco@mail.com"),
        Friend(id: UUID(), name: "Sofia", mail: "sofia@mail.com"),
        Friend(id: UUID(), name: "Alessandro", mail: "alessandro@mail.com"),
        Friend(id: UUID(), name: "Martina", mail: "martina@mail.com"),
        Friend(id: UUID(), name: "Giorgio", mail: "giorgio@mail.com"),
        Friend(id: UUID(), name: "Valeria", mail: "valeria@mail.com"),
        Friend(id: UUID(), name: "Davide", mail: "davide@mail.com"),
        Friend(id: UUID(), name: "Chiara", mail: "chiara@mail.com"),
        Friend(id: UUID(), name: "Elena", mail: "elena@mail.com"),
        Friend(id: UUID(), name: "Riccardo", mail: "riccardo@mail.com"),
        Friend(id: UUID(), name: "Alice", mail: "alice@mail.com")
    ]
}
