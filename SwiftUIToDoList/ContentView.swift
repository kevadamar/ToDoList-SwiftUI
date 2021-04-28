//
//  ContentView.swift
//  SwiftUIToDoList
//
//  Created by keva damar galih on 28/04/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(fetchRequest: ToDoService.getAllToDoService()) var items: FetchedResults<ToDoService>
    
    @State var text: String = ""
    
    var body: some View {
        NavigationView{
            List {
                Section(header: Text("New Item")){
                    HStack{
                        TextField("Enter New ToDo", text: $text)
                        Button(action: {
                            if !text.isEmpty{
                                let newItem = ToDoService(context: context)
                                
                                newItem.name = text
                                newItem.createdAt = Date()
                                 
                                do{
                                    try context.save()
                                } catch{
                                    print(error)
                                }
                                
                                text = ""
                            }
                        }, label: {
                            Text("Save")
                        })
                    }
                }
                Section {
                    ForEach(items){ item in
                        VStack(alignment: .leading){
                            Text(item.name!)
                                .font(.headline)
                            Text("\(item.createdAt!)")
                             
                        }
                    }.onDelete { (IndexSet) in
                        guard let indexItem = IndexSet.first else {return}
                        let deleteItem = items[indexItem]
                        context.delete(deleteItem)
                        do{
                            try context.save()
                        } catch{
                            print(error)
                        }
                    }
                }
            }
            .navigationTitle("To Do List")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
struct ToggleButton: View {
    var body: some View{
        Button(action: {}, label: {
            Text("gas")
        })
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


