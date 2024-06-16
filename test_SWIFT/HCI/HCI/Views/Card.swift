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
                
                
                HStack{
                    
                    Image("Image")
                        .resizable()
                    
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
                
                
            }
            Spacer()
        }
        .background(Color.black.opacity(0.5))
    }
}



struct Card_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
