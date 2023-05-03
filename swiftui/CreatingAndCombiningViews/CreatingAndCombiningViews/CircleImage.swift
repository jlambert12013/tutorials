//
//  CircleImage.swift
//  CreatingAndCombiningViews
//
//  Created by Jim Lambert on 5/3/23.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("turtlerock")
            .clipShape(Circle())
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
