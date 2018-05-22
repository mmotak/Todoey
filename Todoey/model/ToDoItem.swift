//
//  ToDoItem.swift
//  Todoey
//
//  Created by Maciej Motak on 19/05/2018.
//  Copyright © 2018 Maciej Motak. All rights reserved.
//

import Foundation

public class ToDoItem: NSObject, NSCoding, Codable {
    private static let TEXT_KEY = "text"
    private static let CHECKED_KEY = "checked"
    
    public var title : String
    public var done : Bool
    
    public init(text: String, checked: Bool) {
        self.done = checked
        self.title = text
    }
    
    public required init(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: ToDoItem.TEXT_KEY) as? String ?? ""
        self.done = aDecoder.decodeBool(forKey: ToDoItem.CHECKED_KEY)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: ToDoItem.TEXT_KEY)
        aCoder.encode(self.done, forKey: ToDoItem.CHECKED_KEY)
    }
}
