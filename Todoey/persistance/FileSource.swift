//
//  FileSource.swift
//  Todoey
//
//  Created by Maciej Motak on 20/05/2018.
//  Copyright © 2018 Maciej Motak. All rights reserved.
//

import Foundation

public class FileSource : PersistanceSource {
    private static let FILE_NAME = "ToDoItems.plist"
    
    private let encoder = PropertyListEncoder()
    private let decoder = PropertyListDecoder()
    
    private let toDoItemsFile = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(FileSource.FILE_NAME)
    
    init() {
        print(toDoItemsFile)
    }
    
    func save(list: [ToDoItem]) {
        do {
            let dataToSave = try encoder.encode(list)
            try dataToSave.write(to: toDoItemsFile!)
        } catch {
            print(error)
        }
    }
    
    func load() -> [ToDoItem] {
            if let dataLoaded = try? Data(contentsOf: toDoItemsFile!) {
                do {
                    return try decoder.decode([ToDoItem].self, from: dataLoaded)
                } catch {
                    print(error)
                }
            }
        
        return [ToDoItem]()
    }
    
    
}
