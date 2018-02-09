//
//  PlanningViewController.swift
//  One Thing
//
//  Created by Robert Hatfield on 6/20/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

import UIKit
import UICircularProgressRing

class PlanningViewController: UIViewController {
    @IBOutlet weak var firstTaskTextField: UITextField!
    @IBOutlet weak var secondTaskTextField: UITextField!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var progressRingView: UICircularProgressRingView!
    @IBOutlet weak var doneButton: UIButton!
    
    var taskList = TaskList.sharedInstance
    var firstIndex = 0, secondIndex = 1
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        firstIndex = 0
        secondIndex = 1
        print("firstIndex: \(firstIndex) \nsecondIndex: \(secondIndex)")
        taskList.activeTasks = [0]
        progressRingView.value = 0.0
        taskList.allTasks.first?.isSelected = true
        
        updateView()
    }

    func updateView() {
        let progress : CGFloat = CGFloat(secondIndex - 1) / CGFloat(taskList.allTasks.count - 1) * 100
        progressRingView.setProgress(value: progress, animationDuration: 0.2)
        
        print("Progress: \(progress)\nValue: \(progressRingView.value)")
        print("\(secondIndex) / \(taskList.allTasks.count)")
        
        // Verify indices are not out of bounds of the array.
        if secondIndex >= taskList.allTasks.count {
            noButton.isHidden = true; noButton.isEnabled = false
            yesButton.isHidden = true; yesButton.isEnabled = false
            doneButton.isHidden = false; doneButton.isEnabled = true
            return
        } else {
            noButton.isHidden = false; noButton.isEnabled = true
            yesButton.isHidden = false; yesButton.isEnabled = true
            doneButton.isHidden = true; doneButton.isEnabled = false
        }
        
        firstTaskTextField.text = taskList.allTasks[firstIndex].text
        secondTaskTextField.text = taskList.allTasks[secondIndex].text
    }

    
    // MARK: - User actions
    @IBAction func noButtonPressed(_ sender: Any) {
        taskList.allTasks[secondIndex].isSelected = false
        secondIndex += 1
        updateView()
    }
    
    @IBAction func yesButtonPressed(_ sender: Any) {
        taskList.allTasks[secondIndex].isSelected = true
        taskList.activeTasks.append(secondIndex)
        firstIndex = taskList.activeTasks.last!
        secondIndex += 1
        updateView()
    }
    
    @IBAction func doneButtonPressed() {
        taskList.saveTasks()
        self.tabBarController?.selectedIndex = 0
    }
    
}
