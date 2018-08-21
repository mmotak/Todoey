//
//  RItem.swift
//  Todoey
//
//  Created by Maciej Motak on 18.08.2018.
//  Copyright © 2018 Maciej Motak. All rights reserved.
//

import Foundation
import RealmSwift

class RItem : Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var date: Date = Date()
    var parentCategory = LinkingObjects(fromType: RCategory.self, property: "items")
}
