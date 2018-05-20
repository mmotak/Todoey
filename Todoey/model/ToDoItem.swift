//
//  ToDoItem.swift
//  Todoey
//
//  Created by Maciej Motak on 19/05/2018.
//  Copyright © 2018 Maciej Motak. All rights reserved.
//

import Foundation

public class ToDoItem: NSObject, NSCoding {
    private static let TEXT_KEY = "text"
    private static let CHECKED_KEY = "checked"
    
    public var text : String
    public var checked : Bool
    
    public init(text: String, checked: Bool) {
        self.checked = checked
        self.text = text
    }
    
    public required init(coder aDecoder: NSCoder) {
        self.text = aDecoder.decodeObject(forKey: ToDoItem.TEXT_KEY) as? String ?? ""
        self.checked = aDecoder.decodeBool(forKey: ToDoItem.CHECKED_KEY)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.text, forKey: ToDoItem.TEXT_KEY)
        aCoder.encode(self.checked, forKey: ToDoItem.CHECKED_KEY)
    }
}
