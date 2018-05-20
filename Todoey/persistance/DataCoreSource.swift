//
//  DataCoreSource.swift
//  Todoey
//
//  Created by Maciej Motak on 20/05/2018.
//  Copyright © 2018 Maciej Motak. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class DataCoreSource : PersistanceSource {
    let appDelegate : AppDelegate
    let context : NSManagedObjectContext
    
    init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    func save(list: [ToDoItem]) {
        deleteAll()
        addToContext(items: list)
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    private func deleteAll() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoItemDb")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func load() -> [ToDoItem] {
        let request : NSFetchRequest<ToDoItemDb> = ToDoItemDb.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            //itemsDb = result
            return convertToModel(dbItems: result)
        } catch {
            print(error)
        }
        
        return [ToDoItem]()
    }
    
    private func convertToDb(toDoItem: ToDoItem) -> ToDoItemDb {
        let toDoItemDb = ToDoItemDb(context: context)
        toDoItemDb.title = toDoItem.text
        toDoItemDb.done = toDoItem.checked
        return toDoItemDb
    }
    
    private func addToContext(toDoItem: ToDoItem) {
        let toDoItemDb = ToDoItemDb(context: context)
        toDoItemDb.title = toDoItem.text
        toDoItemDb.done = toDoItem.checked
    }
    
    private func convertToModel(toDoItemDb: ToDoItemDb) -> ToDoItem {
        return ToDoItem(text: toDoItemDb.title!, checked: toDoItemDb.done)
    }
    
    private func convertToDb(items: [ToDoItem]) -> [ToDoItemDb] {
        var list = [ToDoItemDb]()
        
        for item in items {
            list.append(convertToDb(toDoItem: item))
        }
        
        return list
    }
    
    private func addToContext(items: [ToDoItem]) {
        for item in items {
            addToContext(toDoItem: item)
        }
    }
    
    private func convertToModel(dbItems: [ToDoItemDb]) -> [ToDoItem] {
        var list = [ToDoItem]()
        
        for item in dbItems {
            list.append(convertToModel(toDoItemDb: item))
        }
        
        return list
    }

}
