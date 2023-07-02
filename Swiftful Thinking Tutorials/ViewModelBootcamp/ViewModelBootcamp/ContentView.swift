//
//  ContentView.swift
//  ViewModelBootcamp
//
//  Created by Jim Lambert on 7/2/23.
//  Swiftful Thinking Tutorial on @ObservableObjects
//  https://www.youtube.com/watch?v=-yjKAb0Pj60&t=82s
import SwiftUI

struct FruitModel: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let count: Int
}


class FruitViewModel: ObservableObject {

    //  RIGHT WAY - Seperating out the logic in a class that conforms to Observable Object
    @Published var fruitArray: [FruitModel] = []    // "@Published is the same as @State, except it is in a Class"

    func getFruits() {
        let fruit1 = FruitModel(name: "Orange", count: 7)
        let fruit2 = FruitModel(name: "Banana", count: 4)
        let fruit3 = FruitModel(name: "Watermelon", count: 2)
        let fruit4 = FruitModel(name: "Tomato", count: 9)
        let fruit5 = FruitModel(name: "Strawberry", count: 1)
        let fruit6 = FruitModel(name: "Orange", count: 7)

        fruitArray.append(fruit1)
        fruitArray.append(fruit2)
        fruitArray.append(fruit3)
        fruitArray.append(fruit4)
        fruitArray.append(fruit5)
        fruitArray.append(fruit6)
    }

    func deleteFruit(index: IndexSet) {
        fruitArray.remove(atOffsets: index)
    }
}


struct ContentView: View {

    //  WRONG WAY - Before Refactored way using @Published
    //    @State var fruitArray: [FruitModel] = [FruitModel(name: "Apples", count: 5)]

    //  RIGHT WAY - Using @Publsihed property wrapper. @ObservedObject tell view to listen for changes on @Published Properties.
    @ObservedObject var fruitViewModel: FruitViewModel = FruitViewModel()
    
    var body: some View {
        VStack {
            NavigationStack {
                List {
                    ForEach(fruitViewModel.fruitArray) { fruit in
                        HStack {
                            Text("\(fruit.count)").foregroundColor(.red)
                            Text(fruit.name)
                                .font(.headline)
                                .bold()
                        }
                    }.onDelete(perform: fruitViewModel.deleteFruit)
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("Fruit List")
                .onAppear {
                    fruitViewModel.getFruits()
                }
            }
        }



        //  WRONG WAY - You want to seperate logic from views. You do this be creating a View Model to handle the logic.
        //        func getFruits() {
        //            let fruit1 = FruitModel(name: "Orange", count: 7)
        //            let fruit2 = FruitModel(name: "Banana", count: 4)
        //            let fruit3 = FruitModel(name: "Watermelon", count: 2)
        //            let fruit4 = FruitModel(name: "Tomato", count: 9)
        //            let fruit5 = FruitModel(name: "Strawberry", count: 1)
        //            let fruit6 = FruitModel(name: "Orange", count: 7)
        //
        //            fruitArray.append(fruit1)
        //            fruitArray.append(fruit2)
        //            fruitArray.append(fruit3)
        //            fruitArray.append(fruit4)
        //            fruitArray.append(fruit5)
        //            fruitArray.append(fruit6)
        //        }
        //
        //        func deleteFruit(index: IndexSet) {
        //            fruitArray.remove(atOffsets: index)
        //        }
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
