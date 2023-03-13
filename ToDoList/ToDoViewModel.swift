//
//  ToDoViewModel.swift
//  ToDoList
//
//  Created by George Sigety on 3/11/23.
//

import Foundation

class ToDoViewModel: ObservableObject {
    @Published var toDos: [ToDo] = []
    
    init() {
//        purgeData()
        loadData()
    }
    
    func saveToDo(toDo: ToDo) {
        //if new, append to toDoVM.toDo else update the toDo that was passed in from the list
        if toDo.id == nil {
            var newToDo = toDo
            newToDo.id = UUID().uuidString
            toDos.append(newToDo)
        } else {
            if let index = toDos.firstIndex(where: {$0.id == toDo.id}) {
                toDos[index] = toDo
            }
        }
        saveData()
    }
    
    func toggleCompleted(toDo: ToDo) {
        guard toDo.id != nil else {return}
        var newToDo = toDo
        newToDo.isCompleted.toggle()
        if let index = toDos.firstIndex(where: {$0.id == newToDo.id}) {
                toDos[index] = newToDo
        }
        saveData()
    }
    
    func deleteToDo(indexSet: IndexSet) {
        toDos.remove(atOffsets: indexSet)
        saveData()
    }
    
    func moveToDo(fromOffsets: IndexSet, toOffset: Int) {
        toDos.move(fromOffsets: fromOffsets, toOffset: toOffset)
        saveData()
    }
    
    func saveData() {
        let path = URL.documentsDirectory.appending(component: "toDos")
        let data = try? JSONEncoder().encode(toDos) //try? means that if error is thrown, data = nil
        do {
            try data?.write(to: path)
        } catch {
            print("😡 ERROR: could not save data \(error.localizedDescription)")
        }
    }
    
    func loadData() {
        let path = URL.documentsDirectory.appending(component: "toDos")
        guard let data = try? Data(contentsOf: path) else {return}
        do {
            toDos = try JSONDecoder().decode(Array<ToDo>.self, from: data)
        } catch {
            print("😡 ERROR: could not save data \(error.localizedDescription)")
        }
    }
    
    func purgeData() {
        let path = URL.documentsDirectory.appending(component: "toDos")
        let data = try? JSONEncoder().encode("")
        do {
            try data?.write(to: path)
        } catch {
            print("😡 ERROR: could not save data \(error.localizedDescription)")
        }
    }
}
