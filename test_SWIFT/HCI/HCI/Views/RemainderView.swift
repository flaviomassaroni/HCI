//
//  RemainderView.swift
//  HCI
//
//  Created by Andrea Salinetti on 14/06/24.
//

import SwiftUI


struct RemainderView: View {
    @Binding var recipient: String
    var body: some View {
        VStack{
            Spacer()
            ZStack{
                
                RoundedRectangle(cornerRadius: 14)
                    .frame(width: 400, height:200)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                HStack{
                    Image(systemName: "checkmark.message")

                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .padding(5)
                    Text("A remainder was \nsent to \n\(recipient)")
                        .fontWeight(.semibold)
                        .font(.system(size: 25))
                }
                
                
            }
            Spacer()
        }.background(Color.black.opacity(0.5))
    }
}

#Preview {
    RemainderView(recipient: .constant("Marco"))
}
