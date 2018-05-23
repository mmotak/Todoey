//
//  CategoryDbSource.swift
//  Todoey
//
//  Created by Maciej Motak on 23/05/2018.
//  Copyright © 2018 Maciej Motak. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class CategoryDbSource {
    private let appDelegate : AppDelegate
    private let context : NSManagedObjectContext
    private var list : [CategoryDb] = [CategoryDb]()
    
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
        let request : NSFetchRequest<CategoryDb> = CategoryDb.fetchRequest()
//        if (query != nil) {
//            request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", query!)
//        }
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
    
    public func getItem(at index : Int) -> CategoryDb {
        return list[index]
    }
    
    private func createNew(_ title: String) -> CategoryDb {
        let categoryDb = CategoryDb(context: context)
        categoryDb.name = title
        return categoryDb
    }
    
    private func save() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    private func deleteAll() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CategoryDb")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    private func load(request : NSFetchRequest<CategoryDb> = CategoryDb.fetchRequest()) -> [CategoryDb] {
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do {
            return try context.fetch(request)
        } catch {
            print(error)
        }
        
        return [CategoryDb]()
    }
}
