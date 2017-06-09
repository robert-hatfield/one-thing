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
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let text = aDecoder.decodeObject(forKey: "text") as? String else {
            NSLog("Unable to decode name for task.")
            return nil
        }
        let isSelected = aDecoder.decodeBool(forKey: "isSelected")
        
        self.init(text: text)
        self.isSelected = isSelected
    }
}
