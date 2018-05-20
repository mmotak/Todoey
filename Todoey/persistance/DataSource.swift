//
//  DataSource.swift
//  Todoey
//
//  Created by Maciej Motak on 19/05/2018.
//  Copyright © 2018 Maciej Motak. All rights reserved.
//

import Foundation

public class DataSource {
    private var list = [ToDoItem]()
    private let persistanceSource : PersistanceSource
    
    public static func withUserDefaults() -> DataSource {
        return DataSource(UserDefaultsSource())
    }
    
    public static func withFile() -> DataSource {
        return DataSource(FileSource())
    }
    
    public static func withCoreData() -> DataSource {
        return DataSource(DataCoreSource())
    }
    
    private init(_ p : PersistanceSource) {
        self.persistanceSource = p
        loadListFromStorage()
    }
    
    private func loadListFromStorage() {
        list = persistanceSource.load()
    }
    
    public func saveListToStorage() {
        persistanceSource.save(list: list)
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
