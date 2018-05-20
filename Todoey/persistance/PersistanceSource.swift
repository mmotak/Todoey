//
//  PersistanceSource.swift
//  Todoey
//
//  Created by Maciej Motak on 20/05/2018.
//  Copyright © 2018 Maciej Motak. All rights reserved.
//

import Foundation

protocol PersistanceSource {
    func save(list: [ToDoItem])
    func load() -> [ToDoItem]
}
