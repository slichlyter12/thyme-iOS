//
//  ContentView.swift
//  Thyme-iOS
//
//  Created by Samuel Lichlyter on 7/25/20.
//

import SwiftUI

struct RecipeDetail: View {
    var body: some View {
        VStack {
            CircleImage()
            VStack(alignment: .leading) {
                Text("Gluten Free Brownies")
                    .font(.title)
                HStack {
                    Text("Trader Joe's")
                        .font(.subheadline)
                    Spacer()
                    Text("Dessert")
                        .font(.subheadline)
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail()
    }
}
