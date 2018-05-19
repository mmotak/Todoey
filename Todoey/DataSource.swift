//
//  DataSource.swift
//  Todoey
//
//  Created by Maciej Motak on 19/05/2018.
//  Copyright © 2018 Maciej Motak. All rights reserved.
//

import Foundation

public class DataSource {
    private static let KEY = "ToDoListPresistance"
    
    private var list = [String]()
    private let defaults = UserDefaults.standard
    
    init() {
        if let items = defaults.array(forKey: DataSource.KEY) as? [String] {
            list = items
        }
    }
    
    private func saveListToStorage() {
        defaults.set(list, forKey: DataSource.KEY)
    }
    
    public func size() -> Int {
        return list.count
    }
    
    public func getString(_ index: Int) -> String {
        return list[index]
    }
    
    public func addNewString(_ text: String) {
        list.append(text)
        saveListToStorage()
    }
}
