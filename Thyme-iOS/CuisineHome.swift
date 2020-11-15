//
//  CuisineHome.swift
//  Thyme-iOS
//
//  Created by Samuel Lichlyter on 7/25/20.
//

import SwiftUI

struct CuisineHome: View {
    var recipes: [Recipe]
    
    var cuisines: [String: [Recipe]] {
        Dictionary(grouping: recipes) { $0.cuisine.rawValue }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(cuisines.keys.sorted(), id: \.self) { key in
                    CuisineRow(cuisineName: key, items: self.cuisines[key]!)
                }
                .listRowInsets(EdgeInsets())
                
                NavigationLink(destination: RecipeList(recipes: recipes)) {
                    Text("See All")
                }
            }
            .navigationBarTitle(Text("Cuisines"))
            
            Text("Select a recipe")
        }
    }
}

struct CuisineHome_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CuisineHome(recipes: recipeData)
            CuisineHome(recipes: recipeData)
                .preferredColorScheme(.dark)
        }
    }
}
