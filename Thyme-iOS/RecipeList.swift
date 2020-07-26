//
//  RecipeList.swift
//  Thyme-iOS
//
//  Created by Samuel Lichlyter on 7/25/20.
//

import SwiftUI

struct RecipeList: View {
    var body: some View {
        List(recipeData) { recipe in
            NavigationLink(destination: RecipeDetail(recipe: recipe)) {
                RecipeRow(recipe: recipe)
            }
        .navigationBarTitle(Text("Recipes"))
        }
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipeList()
        }
    }
}
