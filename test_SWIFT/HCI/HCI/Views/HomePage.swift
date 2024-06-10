import SwiftUI

struct HomePage: View {
    @EnvironmentObject var viewModel: FinanceViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing:0) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 14)
                            .foregroundColor(Color.blue)
                        
                        VStack {
                            Spacer() // Pushes the content to the bottom
                            VStack(alignment: .leading) {
                                
                                HStack{
                                    Spacer()
                                    VStack(spacing: 0){
                                        Image(systemName: "creditcard.circle")
                                            .resizable()
                                            .foregroundColor(.white)
                                            .frame(width: 50, height: 50)
                                        Text("Card")
                                            .foregroundColor(.white)
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            .padding(0)
                                    }.padding(.top, -30)

                                }
                                    .frame(height: 15.0)
                                
                                HStack {
                                    Text("Your Balance")
                                        .foregroundColor(.white)
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                        .bold()
                                        .padding(.bottom, -1)
                                        
                                    Spacer()
                                }
                                Text("€\(viewModel.balance, specifier: "%.2f")")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                    .padding(.top, 1)
                                    .fontWeight(.semibold)
                            }
                            .padding(.horizontal, 25)
                            .padding(.bottom, 30)
                        }
                    }
                    .frame(height: 280)
                    .padding(.top, -50)

                    
                    HStack{
                        Text("Your Transactions")
                            .font(.system(size: 22))
                                .padding(.leading)
                                .bold()
                                .foregroundColor(Color(hex:"747476"))
                                .padding(.bottom, 8)
                        Spacer()
                    }.padding(.top, 20)
                    
                    ForEach(viewModel.transactions, id: \.id) { transaction in

                        HStack {
                            ZStack{
                                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                    .frame(width:40 , height: 40)
                                    .padding(.trailing, 10)
                                    .padding(.leading, 10)
                                    .padding(.vertical, 12)
                                    .foregroundColor(transaction.category.colour)
                                Image(transaction.category.iconName)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(transaction.name)
                                    .font(.headline)
                                Text("\(transaction.date) \(transaction.time)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            VStack{
                                HStack{
                                    Spacer()
                                    Text("\(transaction.amount, specifier: "%.2f")€")
                                        .font(.headline)
                                }
                                HStack{
                                    Spacer()
                                    Text(transaction.location)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }.padding(.trailing, 10)
                        }.background(Color(.white))
                            .cornerRadius(14)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 1)
                            
                    }
                    .listStyle(PlainListStyle())
                }.background(Color(hex:"ECECEE"))
                Spacer()
            }.background(Color(hex:"ECECEE"))
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage().environmentObject(FinanceViewModel())
    }
}



