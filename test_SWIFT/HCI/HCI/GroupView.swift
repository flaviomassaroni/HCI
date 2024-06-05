import SwiftUI

struct GroupsView: View {
    var body: some View {
        VStack {
            // Top Bar
            VStack {
                // Header
                HStack {
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
                
                // Groups Section
                VStack {
                    Text("Groups")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding()
            }
            .frame(height: 200)
            .background(Color(hex: "3B46F1"))
            .cornerRadius(14)
            .padding(.horizontal)
            
            // Group Details
            VStack(spacing: 10) {
                GroupItemView(title: "Boat", startDate: "23/05/24", endDate: "30/06/25", progress: 0.23, amount: "550/6000€")
                GroupItemView(title: "Spain Holidays", startDate: "23/05/24", endDate: "30/06/25", progress: 0.43, amount: "850/2000€")
                GroupItemView(title: "Graduation Present", startDate: "23/05/24", endDate: "30/06/25", progress: 0.83, amount: "250/300€")
            }
            .padding()
            
            Spacer()
        }
        .background(Color(UIColor.systemGray6))
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct GroupItemView: View {
    var title: String
    var startDate: String
    var endDate: String
    var progress: Double
    var amount: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
            HStack {
                Text(startDate)
                Image(systemName: "arrow.right")
                Text(endDate)
            }
            .font(.subheadline)
            .foregroundColor(.gray)
            HStack {
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color.green))
                    .frame(height: 8)
                Text("\(Int(progress * 100))%")
                    .font(.caption)
                    .foregroundColor(.green)
            }
            HStack {
                Spacer()
                Text(amount)
                    .font(.headline)
                    .fontWeight(.bold)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
