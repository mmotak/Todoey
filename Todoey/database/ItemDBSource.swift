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

public class ItemDBSource {
    private let appDelegate : AppDelegate
    private let context : NSManagedObjectContext
    private var list : [ToDoItemDb] = [ToDoItemDb]()
    private let categoryDb : CategoryDb
    
    init(_ categoryDb : CategoryDb) {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        self.categoryDb = categoryDb
        loadAll()
    }
    
    public func add(withTitle title: String) {
        list.append(createNew(title))
        save()
    }
    
    public func loadAll(query : String? = nil) {
        let request : NSFetchRequest<ToDoItemDb> = ToDoItemDb.fetchRequest()
        print(categoryDb.name)
        let categoryPredicate = NSPredicate(format: "category.name MATCHES %@", categoryDb.name!)
        
        if (query != nil) {
            let queryPredicate = NSPredicate(format: "title CONTAINS[cd] %@", query!)
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [queryPredicate, categoryPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        list = load(request: request)
        print(list)
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
        toDoItemDb.category = categoryDb
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
    
    private func load(request : NSFetchRequest<ToDoItemDb>) -> [ToDoItemDb] {
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

