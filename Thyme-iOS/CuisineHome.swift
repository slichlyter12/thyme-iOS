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
    
    @State var showNewRecipeSheet: Bool = false
    
    var body: some View {
        NavigationView {
            Group {
                if recipes.count > 0 {
                    List {
                        ForEach(cuisines.keys.sorted(), id: \.self) { key in
                            CuisineRow(cuisineName: key, items: self.cuisines[key]!)
                        }
                        .listRowInsets(EdgeInsets())
                        
                        NavigationLink(destination: RecipeList(recipes: recipes)) {
                            Text("See All")
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("New") {
                                showNewRecipeSheet.toggle()
                            }
                        }
                    }
                    .navigationBarTitle(Text("Cuisines"))
                } else {
                    VStack {
                        Text("No recipes found 😥")
                            .padding()
                        Button("Write down a new recipe...") {
                            showNewRecipeSheet.toggle()
                        }
                    }
                }
            }
            .sheet(isPresented: $showNewRecipeSheet) {
                NewRecipeView(isPresented: $showNewRecipeSheet)
            }
        }
    }
}

struct CuisineHome_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CuisineHome(recipes: [Recipe]())
            CuisineHome(recipes: localRecipes)
            CuisineHome(recipes: localRecipes)
                .preferredColorScheme(.dark)
        }
    }
}
