//
//  LandmarkRows.swift
//  BuildingListsAndNavigation
//
//  Created by Jim Lambert on 5/3/23.
//

import SwiftUI

struct LandmarkRows: View {
    
    var landmark: Landmark
    
    var body: some View {
        Text(landmark.name)
    }
}

struct LandmarkRows_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkRows(landmark: landmarks[0])
    }
}
