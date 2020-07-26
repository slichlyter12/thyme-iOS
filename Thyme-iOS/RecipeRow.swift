//
//  RecipeRow.swift
//  Thyme-iOS
//
//  Created by Samuel Lichlyter on 7/25/20.
//

import SwiftUI

struct RecipeRow: View {
    var recipe: Recipe
    
    var body: some View {
        HStack {
            recipe.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(recipe.name)
            Spacer()
        }
    }
}

struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RecipeRow(recipe: recipeData[0])
            RecipeRow(recipe: recipeData[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
