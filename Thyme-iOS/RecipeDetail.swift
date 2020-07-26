//
//  RecipeDetail.swift
//  Thyme-iOS
//
//  Created by Samuel Lichlyter on 7/25/20.
//

import SwiftUI

struct RecipeDetail: View {
    
    var recipe: Recipe
    
    var body: some View {
        VStack {
            CircleImage(image: recipe.image)
                .padding(.top, 15)
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.title)
                
                HStack(alignment: .top) {
                    Text(recipe.author)
                        .font(.subheadline)
                    Spacer()
                    Text(recipe.cuisine.rawValue)
                        .font(.subheadline)
                }
            }
            .padding()
            
            Spacer()
        }
        .navigationBarTitle(Text(recipe.name), displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(recipe: recipeData[0])
    }
}
