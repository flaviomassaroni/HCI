import SwiftUI

struct ConfirmDeleteButton: View {
    @Binding var Confirmation: Bool
    @ObservedObject var financeModel: FinanceViewModel
    @Binding var group: Group

    var body: some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .frame(width: 400, height:200)
                    .foregroundColor(.white)
                    .padding(.horizontal, 14)

                VStack {
                    Spacer()
                    Text("Would you like to delete \n this group?")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .padding(.bottom, 5)
                    
                    HStack {
                        Button(action: {
                           Confirmation = false
                        }) {
                            Text("Cancel")
                                .frame(width: 130, height: 50)
                                .foregroundColor(.black)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 20)

                        Button(action: {
                            financeModel.deleteFund(groupName: group.name)
                        }) {
                            Text("Delete")
                                .frame(width: 130, height: 50)
                                .foregroundColor(.white)
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 20)
                    }
                    Spacer()
                }
            }
            Spacer()
        }
        .background(Color.black.opacity(0.5))
        
    }
    
}

