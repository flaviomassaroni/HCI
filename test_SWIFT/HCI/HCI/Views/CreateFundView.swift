// Views/CreateFundView.swift
import SwiftUI

struct CreateFundView: View {
    @State private var fundName: String = ""
    @State private var totalAmount: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var friends: [String] = []
    @State private var newFriend: String = ""
    
    @State var screenWidth: CGFloat = UIScreen.main.bounds.width
    @State var screenHeight: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        VStack {
            ZStack{
                RoundedRectangle(cornerRadius: 14)
                .foregroundColor(Color.blue)
                Text("Create New Fund")
                    .font(.largeTitle)
                    .padding()
                    .foregroundColor(Color.white)
                    .fontWeight(.semibold)
            }
            .frame(height:200)
            .padding(.top, -50)
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .foregroundColor(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 3)
                VStack(alignment: .leading, spacing: 5) {
                    Text("Fund Name")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.leading)
                        .foregroundColor(Color.black)
                    
                    ZStack(alignment: .trailing) {
                        TextField("Fuerteventura's Trip", text: $fundName)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .padding(.horizontal)
                        
                        Button(action: {
                            fundName = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 10)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.horizontal, 5)
                .padding(.vertical, 10)
            }
            .frame(width: screenWidth - 28, height: 86)
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .foregroundColor(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 3)
                VStack(alignment: .leading, spacing: 5) {
                    Text("Total amount to save")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.leading)
                        .foregroundColor(Color.black)
                    
                    ZStack(alignment: .trailing) {
                        HStack(spacing: 1) {
                            Text("€")
                                .fontWeight(.bold)
                                .padding(.leading, 1.0)
                            
                            TextField("6000", text: $totalAmount)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                                .padding(.horizontal, 5)
                        }
                        .padding(.leading)
                    
                        Button(action: {
                            totalAmount = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 10)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.trailing, 14)
                }
                .padding(.horizontal, 5)
                .padding(.vertical, 10)
            }
            .frame(width: screenWidth - 28, height: 86)
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            
            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                .padding(.horizontal)
            
            DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                .padding(.horizontal)
            
            Text("Friends")
                .font(.headline)
                .padding(.top)
            
            HStack {
                TextField("Enter your friend's name", text: $newFriend)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                Button(action: {
                    if !newFriend.isEmpty {
                        friends.append(newFriend)
                        newFriend = ""
                    }
                }) {
                    Image(systemName: "plus")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            
            ForEach(friends, id: \.self) { friend in
                HStack {
                    Text(friend)
                    Spacer()
                    Button(action: {
                        if let index = friends.firstIndex(of: friend) {
                            friends.remove(at: index)
                        }
                    }) {
                        Image(systemName: "minus.circle")
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal)
            }
            
            Spacer()
            
            Button(action: {
                // Add fund creation logic here
            }) {
                Text("Create Fund")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("New shared fund")
    }
}

struct CreateFundView_Previews: PreviewProvider {
    static var previews: some View {
        CreateFundView()
    }
}
