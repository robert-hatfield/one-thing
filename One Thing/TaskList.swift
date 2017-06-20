//
//  TaskList.swift
//  One Thing
//
//  Created by Robert Hatfield on 6/19/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

import Foundation
import os.log

class TaskList {
    var allTasks = [Task]() {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AllTasksModified"), object: nil)
        }
    }
    var activeTasks = [Int]()

    static let sharedInstance = TaskList()
    private init() {}
    
    func saveTasks() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(allTasks, toFile: Task.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Tasks saved successfully.", log: OSLog.default, type: .debug)
        } else {
            os_log("Tasks NOT saved successfully.", log: OSLog.default, type: .error)
        }
    }
    
    func loadTasks() -> [Task]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Task.ArchiveURL.path) as? [Task]
    }
    
    
}
