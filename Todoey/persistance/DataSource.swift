//
//  DataSource.swift
//  Todoey
//
//  Created by Maciej Motak on 19/05/2018.
//  Copyright © 2018 Maciej Motak. All rights reserved.
//

import Foundation

public class DataSource {
    private static let KEY = "ToDoItemListPresistance"
    
    private var list = [ToDoItem]()
    private let defaults = UserDefaults.standard
    
    init() {
        loadListFromStorage()
    }
    
    private func loadListFromStorage() {
        guard let dataToLoad = defaults.object(forKey: DataSource.KEY) as? NSData else {
            print("'ToDoItem' not found in UserDefaults")
            return
        }
        
        guard let readList = NSKeyedUnarchiver.unarchiveObject(with: dataToLoad as Data) as? [ToDoItem] else {
            print("Could not unarchive from ToDoItem")
            return
        }
        
        list = readList
    }
    
    public func saveListToStorage() {
        let dataToSave = NSKeyedArchiver.archivedData(withRootObject: list)
        defaults.set(dataToSave, forKey: DataSource.KEY)
    }
    
    public func size() -> Int {
        return list.count
    }
    
    public func getItem(_ index: Int) -> ToDoItem {
        return list[index]
    }
    
    public func addNewItem(_ item: ToDoItem) {
        list.append(item)
        saveListToStorage()
    }
}
