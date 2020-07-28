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
        ScrollView(.vertical, showsIndicators: false) {
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
                
                Text(recipe.description)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
                
                Text("Ingredients:")
                    .font(.subheadline)
                    .textCase(.uppercase)
                    .padding(.top, 20)
                    .padding(.bottom, 5)
                ForEach(recipe.ingredients.keys.sorted(), id: \.self) { key in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(key): ")
                            Spacer()
                            Text(recipe.ingredients[key]!)
                        }
                        Divider()
                    }
                }
                .padding(.leading, 15)
                
                Text("Steps:")
                    .font(.subheadline)
                    .textCase(.uppercase)
                    .padding(.top, 20)
                    .padding(.bottom, 5)
                ForEach(recipe.steps.indices) { index in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(index + 1): ")
                            Text(recipe.steps[index])
                        }
                        Divider()
                    }
                }
                .padding(.leading, 15)
            }
            .padding()
        }
        .navigationBarTitle(Text(recipe.name), displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(recipe: recipeData[2])
    }
}
