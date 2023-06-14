//
//  ContentView.swift
//  DataFlow
//
//  Created by Jim Lambert on 6/14/23.
//

import SwiftUI

struct ContentView: View {

    @State var counter = 0

    var body: some View {
        VStack {
            Text("Your age is \(counter)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
