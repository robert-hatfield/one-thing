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
    @IBOutlet weak var doneLabel: UILabel!
    
    var taskList = TaskList.sharedInstance
    var firstIndex = 0
    var secondIndex = 1
    
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        taskList.saveTasks()
    }

    func updateView() {
        let progress : CGFloat = CGFloat(secondIndex - 1) / CGFloat(taskList.allTasks.count - 1) * 100
        progressRingView.setProgress(value: progress, animationDuration: 0.2)
        
        // Verify indices are not out of bounds of the array.
        if secondIndex >= taskList.allTasks.count {
            noButton.isHidden = true
            yesButton.isHidden = true
            doneLabel.isHidden = false
            return
        } else {
            noButton.isHidden = false
            yesButton.isHidden = false
            doneLabel.isHidden = true
        }
        
        firstTaskTextField.text = taskList.allTasks[firstIndex].text
        secondTaskTextField.text = taskList.allTasks[secondIndex].text

        print("Progress: \(progress)\nValue: \(progressRingView.value)")
        print("\(secondIndex) / \(taskList.allTasks.count)")
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
    
}
