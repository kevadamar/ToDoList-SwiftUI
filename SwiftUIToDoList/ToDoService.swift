//
//  ToDoService.swift
//  SwiftUIToDoList
//
//  Created by keva damar galih on 28/04/21.
//

import Foundation
import CoreData

class ToDoService: NSManagedObject, Identifiable{
    @NSManaged var name: String?
    @NSManaged var createdAt: Date?
}

extension ToDoService{
    
    static func getAllToDoService() -> NSFetchRequest<ToDoService>{
        let request: NSFetchRequest<ToDoService> = ToDoService.fetchRequest() as! NSFetchRequest<ToDoService>
        let sort = NSSortDescriptor(key: "createdAt", ascending: true)
        
        request.sortDescriptors = [sort]
        
        return request
    }
}
