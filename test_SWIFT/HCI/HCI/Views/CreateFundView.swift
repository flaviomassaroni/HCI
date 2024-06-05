// Views/CreateFundView.swift
import SwiftUI

struct CreateFundView: View {
    @State private var fundName: String = ""
    @State private var totalAmount: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var friends: [String] = []
    @State private var newFriend: String = ""
    
    var body: some View {
        VStack {
            Text("Create New Fund")
                .font(.largeTitle)
                .padding()
            
            TextField("Fund Name", text: $fundName)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
            
            TextField("Total amount to save", text: $totalAmount)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
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
