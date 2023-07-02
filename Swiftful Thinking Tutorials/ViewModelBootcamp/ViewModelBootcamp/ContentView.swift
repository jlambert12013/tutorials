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
    
    //  Seperating out the logic in a class that conforms to Observable Object.
    //  "@Published is the same as @State, except it is in a Class."
    @Published var fruitArray: [FruitModel] = []
    @Published var isLoading: Bool = false
    
    //  Creating a custom Initailizer (instead of using "On Appear" like we did originally).
    init() {
        getFruits()
    }
    
    func getFruits() {
        let fruit1 = FruitModel(name: "Orange", count: 7)
        let fruit2 = FruitModel(name: "Banana", count: 4)
        let fruit3 = FruitModel(name: "Watermelon", count: 2)
        let fruit4 = FruitModel(name: "Tomato", count: 9)
        let fruit5 = FruitModel(name: "Strawberry", count: 1)
        let fruit6 = FruitModel(name: "Orange", count: 7)
        
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            
            self.fruitArray.append(fruit1)
            self.fruitArray.append(fruit2)
            self.fruitArray.append(fruit3)
            self.fruitArray.append(fruit4)
            self.fruitArray.append(fruit5)
            self.fruitArray.append(fruit6)
            
            self.isLoading = false
        }
        
        
    }
    
    func deleteFruit(index: IndexSet) {
        fruitArray.remove(atOffsets: index)
    }
}


struct ContentView: View {
    
    //  FIRST WAY - Before Refactored way using @Published
    //  @State var fruitArray: [FruitModel] = [FruitModel(name: "Apples", count: 5)]
    
    //  SECOND WAY - Using @Publsihed property wrapper. @ObservedObject tell view to listen for changes on @Published Properties.
    //  @ObservedObject var fruitViewModel: FruitViewModel = FruitViewModel()
    //  NOTE: The problem with @ObservedObject: when the View is reloaded, the data will also reload. This can be solved by using @StateObject instead.
    
    //  RULE OF THUMB:
    //  Use @StateObject on creation (on init to be more technical. Basically, State Object if it's the first time using the property).
    //  Use @ObservedObject for SubViews (second time using the property).
    //  NOTE: When the FruitViewModel is Initialized when the Object is created by running the getFruits Function (Instead of using on Appear).
    @StateObject var fruitViewModel: FruitViewModel = FruitViewModel()
    
    var body: some View {
        VStack {
            NavigationView {
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
                .navigationBarItems(trailing: NavigationLink(destination: {
                    SecondScreenView()
                }, label: {
                    Image(systemName: "arrow.right")
                        .font(.title)
                }))
                // On Appear will recreate data each time the View Appears (when clicking back for example) which will lead to repeated data appearing every time.
                // To solve this issue we will create a custom initializer in the View Model instead.
                //                .onAppear {
                //                    fruitViewModel.getFruits()
                //                }
            }
        }
        
        
        
        //  BAD WAY - You want to seperate logic from views. You do this be creating a View Model to handle the logic.
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


struct SecondScreenView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    // WHEN TO USE OBSERVED OBJECT?
    // Using @ObservedObject to pass the (already created) data to the second screen.
    // Since we have already created the published Property using @StateObject, so we use @ObservedObject to just pass the data.
    // NOTE: We have already create the object, we are just pass that object data to a new view.
    @ObservedObject var fruitViewModel: FruitViewModel
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            
            VStack {
                ForEach(fruitViewModel.fruitArray) { fruit in
                    Text(fruit.name)
                        .foregroundColor(.white)
                        .font(.headline)
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
