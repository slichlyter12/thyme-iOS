//
//  RecipeList.swift
//  Thyme-iOS
//
//  Created by Samuel Lichlyter on 7/25/20.
//

import SwiftUI

struct RecipeList: View {
    
    var recipes: [Recipe]
    
    var body: some View {
        List(recipes) { recipe in
            NavigationLink(destination: RecipeDetail(recipe: recipe)) {
                RecipeRow(recipe: recipe)
            }
        .navigationBarTitle(Text("All Recipes"))
        }
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipeList(recipes: localRecipes)
        }
    }
}
