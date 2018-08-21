//
//  MainDataSource.swift
//  Todoey
//
//  Created by Maciej Motak on 18.08.2018.
//  Copyright © 2018 Maciej Motak. All rights reserved.
//

import Foundation

public class MainDataSource {
    static let INSTANCE = MainDataSource()
    
    // This class will have the all data source inside
    // files
    // plist
    // datacore
    public let datacore = DataCore()
    // realm
    public let realm = RealmSource()
}

public class DataCore {
    let categoryDbSource = CategoryDbSource()
    func itemDBSource(_ categoryDb : CategoryDb) -> ItemDBSource {
        return ItemDBSource(categoryDb)
    }
}

public class RealmSource {
    let categoryDbSource = RealmCategoryDbSource()
    func itemDBSource(_ categoryDb : RCategory) -> RealmItemDBSource {
        return RealmItemDBSource(categoryDb)
    }
}
