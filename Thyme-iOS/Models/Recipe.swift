//
//  Recipe.swift
//  Thyme-iOS
//
//  Created by Samuel Lichlyter on 7/25/20.
//

import SwiftUI

struct Recipe: Hashable, Codable, Identifiable {
    var id: String?
    var name: String
    var author: String
    var description: String
    var cuisine: Cuisine
    fileprivate var imageName: String
    
    var ingredients: [String: String]?
    var steps: [String]?
    
    enum Cuisine: String, CaseIterable, Codable, Hashable {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
        case dessert = "Dessert"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case author
        case description
        case cuisine
        case imageName
        case ingredients
        case steps
    }
    
    init(name: String, author: String, description: String, cuisine: Cuisine, imageName: String, ingredients: [String: String]?, steps: [String]?) {
        self.name = name
        self.author = author
        self.description = description
        self.cuisine = cuisine
        self.imageName = imageName
        self.ingredients = ingredients
        self.steps = steps
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(author, forKey: .author)
        try container.encode(description, forKey: .description)
        try container.encode(cuisine, forKey: .cuisine)
        try container.encode(imageName, forKey: .imageName)
        try container.encode(ingredients, forKey: .ingredients)
        try container.encode(steps, forKey: .steps)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        author = try container.decode(String.self, forKey: .author)
        description = try container.decode(String.self, forKey: .description)
        cuisine = try container.decode(Cuisine.self, forKey: .cuisine)
        imageName = try container.decode(String.self, forKey: .imageName)
        ingredients = try container.decode([String: String]?.self, forKey: .ingredients)
        steps = try container.decode([String]?.self, forKey: .steps)
    }
    
    func save(completion: @escaping (Bool) -> Void) {
        if id == nil {
            // This is a new recipe
            sendPost() { success in
                completion(success)
            }
        } else {
            // TODO: This is an recipe being updated
        }
    }
    
    private func sendPost(completion: @escaping (Bool) -> Void) {
        let url = URL(string: "http://localhost:8080/api/recipe")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        do {
            let encodedJSON = try JSONEncoder().encode(self)
            request.httpBody = encodedJSON
        } catch {
            print("Failed to encode recipe")
            return
        }
            
        var success: Bool = false
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("error posting to server:", error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 201 {
                    print("non 201 status receieved: \(httpResponse.statusCode)")
                    return
                }
            }
            
            success = true
            completion(success)
        }.resume()
    }
}

extension Recipe {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
}
