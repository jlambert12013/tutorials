//
//  ModelData.swift
//  BuildingListsAndNavigation
//
//  Created by Jim Lambert on 5/3/23.
//

import Foundation


// MODEL
var landmarks: [Landmark] = load("landmarkData.json")

// METHOD FOR PARSING JSON FROM A FILE
func load<T: Decodable> (_ filename: String) -> T {
    
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
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
    } catch  {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
