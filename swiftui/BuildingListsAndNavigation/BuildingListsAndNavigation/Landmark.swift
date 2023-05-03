//
//  Landmark.swift
//  BuildingListsAndNavigation
//
//  Created by Jim Lambert on 5/3/23.
//

import SwiftUI

struct Landmark: Hashable, Codable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
}
