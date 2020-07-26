//
//  CuisineHome.swift
//  Thyme-iOS
//
//  Created by Samuel Lichlyter on 7/25/20.
//

import SwiftUI

struct CuisineHome: View {
    var cuisines: [String: [Recipe]] {
        Dictionary(grouping: recipeData) { $0.cuisine.rawValue }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(cuisines.keys.sorted(), id: \.self) { key in
                    CuisineRow(cuisineName: key, items: self.cuisines[key]!)
                }
                .listRowInsets(EdgeInsets())
                
                NavigationLink(destination: RecipeList()) {
                    Text("See All")
                }
            }
            .navigationBarTitle(Text("Cuisines"))
        }
    }
}

struct CuisineHome_Previews: PreviewProvider {
    static var previews: some View {
        CuisineHome()
    }
}
