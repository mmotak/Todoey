//
//  UserDefaultsPersistanceSource.swift
//  Todoey
//
//  Created by Maciej Motak on 20/05/2018.
//  Copyright © 2018 Maciej Motak. All rights reserved.
//

import Foundation

public class UserDefaultsSource : PersistanceSource {
    private static let KEY = "ToDoItemListPresistance"
    private let defaults = UserDefaults.standard
    
    func save(list: [ToDoItem]) {
        let dataToSave = NSKeyedArchiver.archivedData(withRootObject: list)
        defaults.set(dataToSave, forKey: UserDefaultsSource.KEY)
    }
    
    func load() -> [ToDoItem] {
        guard let dataToLoad = defaults.object(forKey: UserDefaultsSource.KEY) as? NSData else {
            print("'ToDoItem' not found in UserDefaults")
            return [ToDoItem]()
        }
        
        guard let readList = NSKeyedUnarchiver.unarchiveObject(with: dataToLoad as Data) as? [ToDoItem] else {
            print("Could not unarchive from ToDoItem")
            return [ToDoItem]()
        }
        
        return readList
    }
}
