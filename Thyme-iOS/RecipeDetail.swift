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
                // Author + Cuisine
                HStack(alignment: .top) {
                    Text(recipe.author)
                    Spacer()
                    Text(recipe.cuisine.rawValue)
                }
                .font(.subheadline)
                Divider()
                
                // Description
                Text(recipe.description)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 10)
                
                if let ingredients = recipe.ingredients {
                    Text("Ingredients:")
                        .font(.headline)
                        .textCase(.uppercase)
                        .padding(.top, 20)
                        .padding(.bottom, 5)
                    ForEach(ingredients.keys.sorted(), id: \.self) { key in
                        VStack(alignment: .leading) {
                            HStack {
                                Text("\(key): ")
                                Spacer()
                                Text(ingredients[key]!)
                            }
                            Divider()
                        }
                    }
                    .padding(.leading, 15)
                }
                
                if let steps = recipe.steps {
                    Text("Steps:")
                        .font(.headline)
                        .textCase(.uppercase)
                        .padding(.top, 20)
                        .padding(.bottom, 5)
                    ForEach(0..<steps.count, id: \.self) { index in
                        StepRowView(index: index, step: steps[index])
                    }
                    .padding(.leading, 15)
                }
            }
            .padding()
        }
        .navigationBarTitle(Text(recipe.name), displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipeDetail(recipe: localRecipes[2])
        }
    }
}
