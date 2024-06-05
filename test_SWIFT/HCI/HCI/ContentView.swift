import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            // Top Bar
            VStack {
                // Header
                HStack {
                    Image(systemName: "line.horizontal.3")
                        .font(.title)
                        .padding()
                    Spacer()
                    VStack {
                        Image(systemName: "creditcard.fill")
                            .font(.title)
                        Text("Card")
                            .font(.caption)
                    }
                }
                .padding()
                .foregroundColor(.white)
                
                // Balance Section
                HStack {
                    VStack(alignment: .leading) {
                        Text("Your Balance")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        Text("€1927.56")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding()
            }
            .frame(height: 250)
            .background(Color(hex: "3B46F1"))
            .cornerRadius(14)
            
            
            // Transactions Section
            VStack(alignment: .leading) {
                Text("Your Transactions")
                    .font(.headline)
                    .padding(.horizontal)
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(transactions) { transaction in
                            TransactionView(transaction: transaction)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.top)
            
            Spacer()
            
            // Bottom Navigation
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "person.crop.circle")
                    Text("Personal")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                Spacer()
                NavigationLink(destination: GroupsView()) {
                    VStack {
                        Image(systemName: "person.2.square.stack")
                        Text("Groups")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
            }
            .padding()
            .background(Color(hex: "3B46F1"))
            .foregroundColor(.white)
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom) // Add padding for safe area
        }
        .background(Color(UIColor.systemGray6))
        .edgesIgnoringSafeArea(.bottom) // Ensure edges ignore safe area for a full background
    }
}

// Sample Transaction Data
struct Transaction: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let time: String
    let place: String
    let amount: String
    let icon: String
    let iconColor: Color
}

let transactions = [
    Transaction(title: "Patches", date: "25/05/24", time: "09:34", place: "Farmacia 'Igea'", amount: "3.20€", icon: "heart.fill", iconColor: .green),
    Transaction(title: "Coffee", date: "25/05/24", time: "09:34", place: "Bar 'Buongiorno'", amount: "1.10€", icon: "cup.and.saucer.fill", iconColor: .purple),
    Transaction(title: "Groceries", date: "25/05/24", time: "09:34", place: "Eurospin", amount: "24.60€", icon: "cart.fill", iconColor: .yellow),
    Transaction(title: "Headphones", date: "25/05/24", time: "09:34", place: "Mediaworld Roma", amount: "199.90€", icon: "headphones", iconColor: .orange),
    Transaction(title: "Pet Food", date: "16/05/24", time: "09:34", place: "L' Arca", amount: "6.30€", icon: "pawprint.fill", iconColor: .purple),
    Transaction(title: "Groceries", date: "25/05/24", time: "09:34", place: "Conad", amount: "57.20€", icon: "cart.fill", iconColor: .yellow),
    Transaction(title: "Enterogermina", date: "25/05/24", time: "09:34", place: "Farmacia Comunale", amount: "15.70€", icon: "heart.fill", iconColor: .green),
    Transaction(title: "Oki", date: "25/05/24", time: "09:34", place: "Se Non Muori Ritorni", amount: "12.30€", icon: "heart.fill", iconColor: .green)
]

struct TransactionView: View {
    let transaction: Transaction

    var body: some View {
        HStack {
            Image(systemName: transaction.icon)
                .foregroundColor(transaction.iconColor)
                .padding()
                .background(Circle().fill(Color.gray.opacity(0.2)))
            VStack(alignment: .leading) {
                Text(transaction.title)
                    .font(.headline)
                HStack {
                    Text(transaction.date)
                    Text(transaction.time)
                }
                .font(.subheadline)
                .foregroundColor(.gray)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(transaction.amount)
                    .font(.headline)
                Text(transaction.place)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
