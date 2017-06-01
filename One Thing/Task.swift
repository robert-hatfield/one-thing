//
//  Task.swift
//  One Thing
//
//  Created by Robert Hatfield on 6/1/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

import UIKit

class Task: NSObject, NSCoding {
    
    //MARK: Properties
    var text : String
    var isSelected = false
    var isCurrent = false
    
    //MARK: Archiving
    static let DocumentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentDirectory.appendingPathComponent("tasks")
    
    //MARK: Initializer
    init(text: String) {
        self.text = text
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "text")
        aCoder.encode(isSelected, forKey: "isSelected")
        aCoder.encode(isCurrent, forKey: "isCurrent")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard var text = aDecoder.decodeObject(forKey: "text") as? String else {
            NSLog("Unable to decode name for task.")
            return nil
        }
        var isSelected = aDecoder.decodeBool(forKey: "isSelected")
        var isCurrent = aDecoder.decodeBool(forKey: "isCurrent")
        
        self.init(text: text)
        self.isSelected = isSelected
        self.isCurrent = isCurrent
    }
}
