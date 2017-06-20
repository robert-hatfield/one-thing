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
    var taskList = TaskList.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.taskTextField.delegate = self
        self.taskTextField.becomeFirstResponder()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.taskTextField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func addButtonPressed(_ sender: Any) {
        guard let text = taskTextField.text, text != "" else { return }
        
        addTask(text)
        taskList.saveTasks()
        self.taskTextField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        guard let text = taskTextField.text, text != "" else { return }
        
        addTask(text)
        
        guard let newTask = taskList.allTasks.last else { return }
        newTask.isSelected = true
        taskList.activeTasks.append((taskList.allTasks.count) - 1)
        
        taskList.saveTasks()
        self.taskTextField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    func addTask(_ text : String) {
        let newTask = Task(text: text)
        taskList.allTasks.append(newTask)
    }
    
}

extension NewTaskViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let text = textField.text, text != "" else { return false }
        addTask(text)
        taskList.saveTasks()
        textField.text = ""
        return true
    }
}
