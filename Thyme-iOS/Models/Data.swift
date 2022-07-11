/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Helpers for loading images and data.
*/

import SwiftUI

let healthUrl = "http://localhost:8080/api/status"
let recipeUrl = "http://localhost:8080/api/recipe"
let localRecipes: [Recipe] = load("recipeData.json")
let fetchedRecipes: [Recipe]? = fetch(recipeUrl)

func fetch<T: Decodable>(_ urlString: String) -> T? {
    guard let url = URL(string: urlString)
        else {
            fatalError("Couldn't find url: \(urlString)")
    }
    
    var result: T?
    let semaphore = DispatchSemaphore(value: 0)
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Error fetching recipes: \(error.localizedDescription)")
            semaphore.signal()
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            print("non 200 response received")
            semaphore.signal()
            return
        }
        
        print("Response status: \(httpResponse.statusCode)")
        
        guard let data = data else {
            print("No data received")
            semaphore.signal()
            return
        }
        
        do {
            let decoder = JSONDecoder()
            result = try decoder.decode(T.self, from: data)
        } catch {
            NSLog("Couldn't parse \(data) as \(T.self):\n\(error)")
            semaphore.signal()
        }
        
        semaphore.signal()
    }.resume()
    
    _ = semaphore.wait(timeout: .distantFuture)
    return result
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

final class ImageStore {
    typealias _ImageDictionary = [String: CGImage]
    fileprivate var images: _ImageDictionary = [:]

    fileprivate static var scale = 2
    
    static var shared = ImageStore()
    
    func image(name: String) -> Image {
        let index = _guaranteeImage(name: name)
        
        return Image(images.values[index], scale: CGFloat(ImageStore.scale), label: Text(name))
    }

    static func loadImage(name: String) -> CGImage {
        guard
            let url = Bundle.main.url(forResource: name, withExtension: "jpg"),
            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
        else {
            fatalError("Couldn't load image \(name).jpg from main bundle.")
        }
        return image
    }
    
    fileprivate func _guaranteeImage(name: String) -> _ImageDictionary.Index {
        if let index = images.index(forKey: name) { return index }
        
        images[name] = ImageStore.loadImage(name: name)
        return images.index(forKey: name)!
    }
}

