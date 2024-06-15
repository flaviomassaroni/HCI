import SwiftUI


// Custom shape for rounding only top corners
struct TopRoundedRectangle: Shape {
    var cornerRadius: CGFloat
    
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
        path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius), radius: cornerRadius, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius), radius: cornerRadius, startAngle: .degrees(270), endAngle: .degrees(0), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        
        return path
    }
}

// Custom shape for rounding only bottom corners
struct BottomRoundedRectangle: Shape {
    var cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
        path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.closeSubpath()
        
        return path
    }
}

struct GroupMenuView: View {
    @Binding var isVisible: Bool
    @ObservedObject var financeModel: FinanceViewModel
    @Binding var group: Group
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack(spacing: 1) {
                    Button(action:{}){
                    ZStack {
                        TopRoundedRectangle(cornerRadius: 20)
                            .frame(width: 250, height: 50)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        HStack {
                            Text("Modify Group")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                            Image(systemName: "pencil")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding(.leading, 95)
                                .foregroundColor(.black)
                        }
                    }
                }
                    Button(action:{financeModel.deleteFund(groupName: group.name )}){
                        ZStack {
                            BottomRoundedRectangle(cornerRadius: 20)
                                .frame(width: 250, height: 50)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            HStack {
                                Text("Delete Group")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.red)
                                Image(systemName: "xmark.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(.leading, 95)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
            }
            .padding(.trailing, 30)
            .padding(.top, 30)
            Spacer()
        }
        .background(Color.black.opacity(0.5))
        .onTapGesture(perform: {
            isVisible = false
        })
    }
}

#Preview {
    GroupMenuView(isVisible: .constant(true), financeModel: FinanceViewModel(), group: .constant(Group(name: "String", creationDate: "11/02/23", startDate: "11/02/23", endDate: "30/06/23", period: (1, "M"), totalAmount: 1000, currentAmount: 0, contributionAmount: 75, contributionHistory: [], participants: [])))
}
