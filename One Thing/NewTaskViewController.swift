//
//  NewTaskViewController.swift
//  One Thing
//
//  Created by Robert Hatfield on 6/9/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController {

    @IBOutlet weak var taskTextField: UITextField!
    var mainVC : ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.taskTextField.delegate = self
        self.mainVC = (self.navigationController?.viewControllers.first as? ViewController)!
        self.taskTextField.becomeFirstResponder()
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        guard let text = taskTextField.text, text != "" else { return }
        
        addTask(text)
        self.mainVC?.saveTasks()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        guard let text = taskTextField.text, text != "" else { return }
        
        // If there is already an active task, remove its indicator
        if let priorActiveIndex = mainVC?.activeTasks.last {
            let indexPath = IndexPath(row: priorActiveIndex, section: 0)
            let priorActiveCell = mainVC?.tasksTableView.cellForRow(at: indexPath) as? TaskCell
            if let priorTask = mainVC?.allTasks[priorActiveIndex], priorTask.isSelected == true {
                priorActiveCell?.taskImageView.image = #imageLiteral(resourceName: "task_selected")
            } else {
                priorActiveCell?.taskImageView.image = #imageLiteral(resourceName: "task_default")
            }
        }
        
        addTask(text)
        
        guard let newTask = self.mainVC?.allTasks.last else { return }
        newTask.isSelected = true
        mainVC?.activeTasks.append((mainVC?.allTasks.count)! - 1)
        
        self.mainVC?.saveTasks()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func addTask(_ text : String) {
        let newTask = Task(text: text)
        self.mainVC?.allTasks.append(newTask)
    }
    
}

extension NewTaskViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let text = textField.text, text != "" else { return false }
        addTask(text)
        self.mainVC?.saveTasks()
        textField.text = ""
        return true
    }
}
