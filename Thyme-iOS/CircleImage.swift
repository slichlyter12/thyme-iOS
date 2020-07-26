//
//  CircleImage.swift
//  Thyme-iOS
//
//  Created by Samuel Lichlyter on 7/25/20.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    
    var body: some View {
       image
            .resizable()
            .frame(width: 175, height: 175)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("tjgfbrownies"))
    }
}
