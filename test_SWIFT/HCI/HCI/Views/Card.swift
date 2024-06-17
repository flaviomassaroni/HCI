//
//  Card.swift
//  HCI
//
//  Created by Leonardo Scappatura on 16/06/24.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        VStack{
            Spacer()
            ZStack{
                
                VStack{
                    // move the rectangle down
                    
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(width: 150, height: 8)
                        .foregroundColor(Color.white)
                        .padding(.bottom, -0)
                    Image("card ")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.top, -80)
                    
                }
                
                
                
            }
            Spacer()
        }
        .background(Color.black.opacity(0.01))
    }
}



struct Card_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
