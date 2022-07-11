//
//  Thyme_iOSApp.swift
//  Thyme-iOS
//
//  Created by Samuel Lichlyter on 7/25/20.
//

import SwiftUI

@main
struct Thyme_iOSApp: App {
    @State private var recipes = (fetchedRecipes != nil) ? fetchedRecipes! : localRecipes
    
    var body: some Scene {
        WindowGroup {
            CuisineHome(recipes: recipes)
        }
    }
}
