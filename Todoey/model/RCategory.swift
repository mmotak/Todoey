//
//  RCategory.swift
//  Todoey
//
//  Created by Maciej Motak on 18.08.2018.
//  Copyright © 2018 Maciej Motak. All rights reserved.
//

import Foundation
import RealmSwift

class RCategory: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var date: Date = Date()
    let items = List<RItem>()
}
