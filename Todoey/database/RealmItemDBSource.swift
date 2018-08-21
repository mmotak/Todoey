//
//  RealmItemDBSource.swift
//  Todoey
//
//  Created by Maciej Motak on 19.08.2018.
//  Copyright © 2018 Maciej Motak. All rights reserved.
//

import Foundation
import RealmSwift

class RealmItemDBSource {
    private let realm = try! Realm()
    private let rCategory : RCategory?
    private var items : Results<RItem>?
    private let empty : RItem
    
    init(_ rCategory : RCategory?) {
        self.rCategory = rCategory
        self.items = RealmItemDBSource.load(category: rCategory)
        empty = RItem()
        empty.title = "There is no item"
    }
    
    public func size() -> Int {
        return items?.count ?? 1
    }
    
    public func update(at index : Int) -> RItem {
        let item = getItem(at: index)
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error while changing done at item \(item) with error \(error)")
            }
        
        return getItem(at:index)
    }
    
    public func getItem(at index : Int) -> RItem {
        return items?[index] ?? empty
    }
    
    public func loadAll(query : String? = nil) {
        if (query == nil) {
            items = load()
        } else {
            let queryPredicate = NSPredicate(format: "title CONTAINS[cd] %@", query!)
            items = items?.filter(queryPredicate).sorted(byKeyPath: "date", ascending: true)
        }
    }
    
    public func add(withTitle title: String) {
        save(item: createNew(title))
    }
    
    private static func load(category : RCategory?) -> Results<RItem>? {
        return category?.items.sorted(byKeyPath: "title", ascending: true)
    }
    
    private func load() -> Results<RItem>? {
        return rCategory?.items.sorted(byKeyPath: "title", ascending: true)
    }
    
    private func createNew(_ title: String) -> RItem {
        let item = RItem()
        item.title = title

//        rCategory?.items.append(item)
        return item
    }
    
    private func save(item: RItem) {
        do {
            try realm.write {
                rCategory?.items.append(item)
                realm.add(item)
            }
        } catch {
            print("Unable to write \(item) because of \(error)")
        }
    }
}
