//
//  Recipe.swift
//  Thyme-iOS
//
//  Created by Samuel Lichlyter on 7/25/20.
//

import SwiftUI

struct Recipe: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var author: String
    var description: String
    var cuisine: Cuisine
    fileprivate var imageName: String
    
    var ingredients: [String: String]
    var steps: [String]
    
    enum Cuisine: String, CaseIterable, Codable, Hashable {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
        case dessert = "Dessert"
    }
}

extension Recipe {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
}
