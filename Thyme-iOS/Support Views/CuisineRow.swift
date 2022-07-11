//
//  CuisineRow.swift
//  Thyme-iOS
//
//  Created by Samuel Lichlyter on 7/25/20.
//

import SwiftUI

struct CuisineRow: View {
    var cuisineName: String
    var items: [Recipe]
    
    var body: some View {
        VStack {
            Text(self.cuisineName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(self.items) { recipe in
                        NavigationLink(destination: RecipeDetail(recipe: recipe)) {
                            CuisineItem(recipe: recipe)
                        }
                    }
                }
            }
            .frame(height: 185)
        }
    }
}

struct CuisineItem: View {
    var recipe: Recipe
    var body: some View {
        VStack(alignment: .leading) {
            recipe.image
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 155, height: 155)
                .cornerRadius(10)
            Text(recipe.name)
                .foregroundColor(.primary)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}

struct CuisineRow_Previews: PreviewProvider {
    static var previews: some View {
        CuisineRow(
            cuisineName: localRecipes[0].cuisine.rawValue,
            items: Array(localRecipes.prefix(4))
        )
        .previewLayout(.fixed(width: 400, height: 250))
    }
}
