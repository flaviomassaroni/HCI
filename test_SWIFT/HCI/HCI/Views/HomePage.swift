import SwiftUI

struct HomePage: View {
    @EnvironmentObject var viewModel: FinanceViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 14)
                            .foregroundColor(Color.blue)
                        
                        VStack {
                            Spacer() // Pushes the content to the bottom
                            VStack(alignment: .leading) {
                                Text("Bentornato Silvio")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                    .bold()
                                
                                Spacer()
                                    .frame(height: 15.0)
                                
                                HStack {
                                    Text("Your Balance")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Spacer()
                                    Image(systemName: "creditcard")
                                        .foregroundColor(.white)
                                }
                                Text("€\(viewModel.balance, specifier: "%.2f")")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                            }
                            .padding(25)
                        }
                    }
                    .frame(height: 250)
                    .padding(.top, -50)

                    
                    HStack{
                        Text("Your Transactions")
                                .font(.title)
                                .padding(.leading)
                                .bold()
                        Spacer()
                    }
                    
                    List(viewModel.transactions) { transaction in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(transaction.name)
                                    .font(.headline)
                                Text("\(transaction.date) \(transaction.time)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text("\(transaction.amount, specifier: "%.2f")€")
                                .font(.headline)
                            Text(transaction.location)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                // .navigationTitle("HomePage")
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage().environmentObject(FinanceViewModel())
    }
}



