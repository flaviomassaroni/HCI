import SwiftUI

struct HomePage: View {
    @StateObject var financeModel = FinanceViewModel()
    @State private var isShowingCategoryView = false
    @State private var selectedTransaction: Transaction?
    @State private var offset: CGFloat = 0
    @State private var isShowingGroupsView: Bool = false
    
    var body: some View {
        ZStack{
            if isShowingGroupsView{
                GroupsView(financeModel: financeModel, isShowingGroupsView: $isShowingGroupsView)
                    .zIndex(1.0)
            }
            NavigationView {
                ZStack(alignment: .bottom) {
                    VStack(spacing: 0) {
                        VStack(spacing: 0) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 14)
                                    .foregroundColor(Color.blue)
                                VStack {
                                    Spacer()
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Spacer()
                                            VStack(spacing: 0) {
                                                Image(systemName: "creditcard.circle")
                                                    .resizable()
                                                    .foregroundColor(.white)
                                                    .frame(width: 50, height: 50)
                                                Text("Card")
                                                    .foregroundColor(.white)
                                                    .fontWeight(.bold)
                                                    .padding(0)
                                            }
                                            .padding(.top, -30)
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
                                        Text("€\(financeModel.balance, specifier: "%.2f")")
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
                            
                            ScrollView {
                                HStack {
                                    Text("Your Transactions")
                                        .font(.system(size: 22))
                                        .padding(.leading)
                                        .bold()
                                        .foregroundColor(Color(hex: "747476"))
                                        .padding(.bottom, 8)
                                    Spacer()
                                }
                                .padding(.top, 20)
                                
                                ForEach(financeModel.transactions, id: \.id) { transaction in
                                    Button(action: {
                                        self.selectedTransaction = transaction
                                        self.isShowingCategoryView = true
                                    }) {
                                        HStack {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 25.0)
                                                    .frame(width: 40, height: 40)
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
                                                    .foregroundColor(.black)
                                                Text("\(transaction.date) \(transaction.time)")
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                            }
                                            Spacer()
                                            VStack {
                                                HStack {
                                                    Spacer()
                                                    Text("\(transaction.amount, specifier: "%.2f")€")
                                                        .font(.headline)
                                                        .foregroundColor(.black)
                                                }
                                                HStack {
                                                    Spacer()
                                                    Text(transaction.location)
                                                        .font(.subheadline)
                                                        .foregroundColor(.gray)
                                                }
                                            }
                                            .padding(.trailing, 10)
                                        }
                                        .background(Color.white)
                                        .cornerRadius(14)
                                        .padding(.horizontal, 15)
                                        .padding(.vertical, 1)
                                    }
                                }
                                .listStyle(PlainListStyle())
                            }
                            .background(Color(hex: "ECECEE"))
                        }
                        ZStack{
                            RoundedRectangle(cornerRadius: 14)
                                .foregroundColor(Color.blue)
                                .frame(height: 100)
                            HStack{
                                VStack{
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .frame(width:24, height:24)
                                        .foregroundColor(.white)
                                    Text("Personal")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                }
                                Spacer()
                                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                    .frame(width: 1, height: 40)
                                    .foregroundColor(.white)
                                Spacer()
                                Button(action:{
                                    isShowingGroupsView = true
                                }){
                                    VStack{
                                        Image(systemName: "person.3")
                                            .resizable()
                                            .frame(width:40, height:22)
                                            .foregroundColor(.white)
                                        Text("Groups")
                                            .foregroundColor(.white)
                                    }
                                }
                                
                            }.padding(.horizontal, 80)
                        }
                    }
                    .background(Color(hex: "ECECEE"))
                    .edgesIgnoringSafeArea(.bottom)
                    
                    if let selectedTransaction = selectedTransaction, isShowingCategoryView {
                        Color.black.opacity(0.3)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                withAnimation {
                                    self.isShowingCategoryView = false
                                }
                            }
                        
                        CategoryView(selectedTransaction: .constant(selectedTransaction), isShowing: $isShowingCategoryView, financeModel: financeModel)
                            .offset(y: offset)
                            .gesture(DragGesture()
                                .onChanged { gesture in
                                    if gesture.translation.height > 0 {
                                        self.offset = gesture.translation.height
                                    }
                                }
                                .onEnded { gesture in
                                    if gesture.translation.height > 100 {
                                        withAnimation {
                                            self.isShowingCategoryView = false
                                        }
                                    }
                                    self.offset = 0
                                }
                            )
                            .transition(.move(edge: .bottom))
                            .animation(.easeInOut)
                            .zIndex(1) // Ensure it appears on top
                    }
                }
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(financeModel: FinanceViewModel())
    }
}
