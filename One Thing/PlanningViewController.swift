//
//  PlanningViewController.swift
//  One Thing
//
//  Created by Robert Hatfield on 6/20/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

import UIKit

class PlanningViewController: UIViewController {
    @IBOutlet weak var firstTaskTextField: UITextField!
    @IBOutlet weak var secondTaskTextField: UITextField!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!

    var taskList = TaskList.sharedInstance
    var firstIndex = 0
    var secondIndex = 1
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        taskList.activeTasks = [0]
        taskList.allTasks.first?.isSelected = true
        
        updateTextFields()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        taskList.saveTasks()
    }

    func updateTextFields() {
        
        // Verify indices are not out of bounds of the array.
        if secondIndex >= taskList.allTasks.count {
            noButton.isEnabled = false
            yesButton.isEnabled = false
            return
        }
        
        firstTaskTextField.text = taskList.allTasks[firstIndex].text
        secondTaskTextField.text = taskList.allTasks[secondIndex].text
    }

    
    // MARK: - User actions

    @IBAction func noButtonPressed(_ sender: Any) {
        taskList.allTasks[secondIndex].isSelected = false
        secondIndex += 1
        updateTextFields()
    }
    
    
    @IBAction func yesButtonPressed(_ sender: Any) {
        taskList.allTasks[secondIndex].isSelected = true
        taskList.activeTasks.append(secondIndex)
        secondIndex += 1
        updateTextFields()
    }
    
}
