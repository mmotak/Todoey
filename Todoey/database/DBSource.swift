//
//  DBSource.swift
//  Todoey
//
//  Created by Maciej Motak on 22/05/2018.
//  Copyright © 2018 Maciej Motak. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class DBSource {
    private let appDelegate : AppDelegate
    private let context : NSManagedObjectContext
    private var list : [ToDoItemDb] = [ToDoItemDb]()
    //private let dbCreator = ToDoItemDbCreator()
    
    init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        list = load()
    }
    
    public func add(withTitle title: String) {
        list.append(createNew(title))
        save()
    }
    
    public func loadAll(query : String?) {
        let request : NSFetchRequest<ToDoItemDb> = ToDoItemDb.fetchRequest()
        if (query != nil) {
            request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", query!)
        }
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        list = load(request: request)
    }
    
    public func remove(at index: Int) {
        list.remove(at: index)
        save()
    }
    
    public func size() -> Int {
        return list.count
    }
    
    public func update() {
        save()
    }
    
    public func getItem(at index : Int) -> ToDoItemDb {
        return list[index]
    }
    
    private func createNew(_ title: String) -> ToDoItemDb {
        let toDoItemDb = ToDoItemDb(context: context)
        toDoItemDb.title = title
        toDoItemDb.done = false
        return toDoItemDb
    }
    
    private func save() {
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
    
    private func load(request : NSFetchRequest<ToDoItemDb> = ToDoItemDb.fetchRequest()) -> [ToDoItemDb] {
        do {
            return try context.fetch(request)
        } catch {
            print(error)
        }
        
        return [ToDoItemDb]()
    }
}

protocol DbCreator {
    associatedtype DB_ITEM : NSManagedObject
    func create(context: NSManagedObjectContext, text: String) -> DB_ITEM
}

class CategotyDbCreator : DbCreator {
    typealias DB_ITEM = CategoryDb
    
    func create(context: NSManagedObjectContext, text: String) -> CategoryDb {
        let categoryDb = CategoryDb(context: context)
        categoryDb.name = text
        return categoryDb
    }
}

class ToDoItemDbCreator : DbCreator {
    typealias DB_ITEM = ToDoItemDb
    
    func create(context: NSManagedObjectContext, text: String) -> ToDoItemDb {
        let toDoItemDb = ToDoItemDb(context: context)
        toDoItemDb.title = text
        toDoItemDb.done = false
        return toDoItemDb
    }
}

