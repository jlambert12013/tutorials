//
//  ContentView.swift
//  ViewModelBootcamp
//
//  Created by Jim Lambert on 7/2/23.
//
//  Swiftful Thinking Tutorial on @ObservableObjects

import SwiftUI


struct FruitModel: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let count: Int
}


class FruitViewModel {
    /*  @Published is the same as @State, except it is in a Class. **/
    @Published var fruitArray: [FruitModel] = []


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

    //  Before Refactored way using @Published
    @State var fruitArray: [FruitModel] = [FruitModel(name: "Apples", count: 5)]

    /* NEW WAY using @Publsihed property wrapper **/
    var fruitViewModel: FruitViewModel = FruitViewModel()
    
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
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
