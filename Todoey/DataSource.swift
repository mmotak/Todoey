//
//  DataSource.swift
//  Todoey
//
//  Created by Maciej Motak on 19/05/2018.
//  Copyright © 2018 Maciej Motak. All rights reserved.
//

import Foundation

public class DataSource {
    private var list = ["zadanie 1", "zadanie 2", "zadanie 3"]
    
    public func size() -> Int {
        return list.count
    }
    
    public func getString(_ index: Int) -> String {
        return list[index]
    }
    
    public func addNewString(_ text: String) {
        list.append(text)
    }
}
