//
//  RealmCategoryDbSource.swift
//  Todoey
//
//  Created by Maciej Motak on 18.08.2018.
//  Copyright © 2018 Maciej Motak. All rights reserved.
//

import Foundation
import RealmSwift

class RealmCategoryDbSource {
    private let realm = try! Realm()
    private var empty : RCategory
    private var categories : Results<RCategory>?
    
    init() {
        empty = RCategory()
        empty.name = "No Categories"
        
        categories = load()
    }
    
    public func add(withTitle title: String) {
        save(category: createNew(title))
    }
    
    public func size() -> Int {
        return categories?.count ?? 1
    }
    
    public func getItem(at index : Int) -> RCategory {
        return categories?[index] ?? empty
    }
    
    private func load() -> Results<RCategory> {
        return realm.objects(RCategory.self)
    }
    
    private func createNew(_ title: String) -> RCategory {
        let category = RCategory()
        category.name = title
        return category
    }
    
    private func save(category: RCategory) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Unable to write \(category) because of \(error)")
        }
    }
}
