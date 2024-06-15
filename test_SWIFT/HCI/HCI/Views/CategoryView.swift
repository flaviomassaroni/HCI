import SwiftUI

struct CategoryView: View {
    @Binding var selectedTransaction: Transaction
    @Binding var isShowing: Bool
    @ObservedObject var financeModel: FinanceViewModel
    let categories: [Category] = [
        healthCategory, diningCategory, groceriesCategory, petsCategory, housingCategory,
        technologyCategory, transportationCategory, entertainmentCategory, subscriptionsCategory,
        giftsCategory, moneyTransfersCategory, carpentryCategory, educationCategory
    ]
    
    var body: some View {
        if isShowing {
            ZStack{
                RoundedRectangle(cornerRadius: 14)
                    .frame(width: 428, height: 105)
                    .foregroundColor(Color(hex:"ECECEC"))
                VStack{
                    Spacer()
                    ZStack {
                        VStack {
                            RoundedRectangle(cornerRadius: 25.0)
                                .frame(width: 40, height: 5)
                                .foregroundColor(Color(hex: "747476"))
                                .padding(.vertical, 10)
                            HStack{
                                Text("Choose a new Category")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(hex: "747476"))
                                Spacer()
                            }.padding(.leading, 25)
                            
                            ScrollView {
                                ForEach(categories, id: \.id) { category in
                                    Button(action: {
                                        financeModel.editCategory(newCategory:category, transaction: selectedTransaction)
                                        isShowing = false
                                    }) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 10.0)
                                                .frame(width: 380, height: 50)
                                                .foregroundColor(.white)
                                            HStack {
                                                ZStack {
                                                    RoundedRectangle(cornerRadius: 25.0)
                                                        .frame(width: 35, height: 35)
                                                        .foregroundColor(category.colour)
                                                    Image(category.iconName)
                                                        .resizable()
                                                        .frame(width: 25, height: 25)
                                                }
                                                .frame(width: 35, height: 35)
                                                Text(category.name)
                                                    .foregroundColor(.black)
                                                Spacer()
                                            }
                                            .padding(.leading, 40)
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .background(Color(hex: "ECECEC"))
                            .frame(maxWidth: .infinity, maxHeight: 400)
                        }
                        .background(Color(hex: "ECECEC"))
                        .animation(.easeInOut, value: isShowing)
                        
                    }
                }
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(selectedTransaction: .constant(Transaction(id: UUID(), name: "Patches", date: "25/05/24", time: "09:34", amount: 3.20, category: healthCategory, location: "Farmacia Igea")), isShowing: .constant(true), financeModel: FinanceViewModel())
    }
}
