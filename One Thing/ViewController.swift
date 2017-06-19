//
//  ViewController.swift
//  One Thing
//
//  Created by Robert Hatfield on 5/31/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var tasksTableView: UITableView!
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    
    //MARK: Properties
    var allTasks = [Task]() {
        didSet {
            checkActiveTask()
            self.tasksTableView.reloadData()
        }
    }
    var activeTasks = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustViewForKeyboard(notification:)), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustViewForKeyboard(notification:)), name: .UIKeyboardWillChangeFrame, object: nil)
        
        self.tasksTableView.dataSource = self
        self.tasksTableView.delegate = self
        
        let taskNib = UINib(nibName: "TaskCell", bundle: nil)
        self.tasksTableView.register(taskNib, forCellReuseIdentifier: TaskCell.identifier)
        self.tasksTableView.estimatedRowHeight = 50
        self.tasksTableView.rowHeight = UITableViewAutomaticDimension
        
        if let savedTasks = loadTasks() {
            allTasks += savedTasks
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func adjustViewForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            tasksTableView.contentInset = UIEdgeInsets.zero
        } else {
            tasksTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        tasksTableView.scrollIndicatorInsets = tasksTableView.contentInset
        
    }
    
    
    func checkActiveTask() {
        
        // Reset activeTasks array; row assignments may have changed
        self.activeTasks.removeAll()
        var index = 0
            for task in allTasks {
                if task.isSelected {
                    self.activeTasks.append(index)
                }
            index += 1
        }
        
        print("Active tasks: \(activeTasks)")
    }
    
    //MARK: User actions
    func taskCompleted(sender: UIButton) {
        allTasks.remove(at: sender.tag)
        saveTasks()
    }
    
    func taskWorked(sender: UIButton) {
        self.allTasks[sender.tag].isSelected = false
        allTasks.append(allTasks.remove(at: sender.tag))
        if let oldIndex = self.activeTasks.index(of: sender.tag) {
            self.activeTasks.remove(at: oldIndex)
        }
        
        saveTasks()
    }
    
    //MARK: Save & load tasks
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

//MARK: UITableView extension
extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as! TaskCell
        cell.selectionStyle = .none
        let task = self.allTasks[indexPath.row]
        cell.task = task
        
        switch task.isSelected {
        case true:
            if indexPath.row == self.activeTasks.last {
                cell.taskImageView.image = #imageLiteral(resourceName: "task_active")
            } else {
                cell.taskImageView.image = #imageLiteral(resourceName: "task_selected")
            }
        case false:
            cell.taskImageView.image = #imageLiteral(resourceName: "task_default")
        }

        cell.checkmarkButton.tag = indexPath.row
        cell.checkmarkButton.addTarget(self, action: #selector(ViewController.taskCompleted), for: UIControlEvents.touchUpInside)
        
        cell.arrowButton.tag = indexPath.row
        cell.arrowButton.addTarget(self, action: #selector(ViewController.taskWorked), for: UIControlEvents.touchUpInside)
        
        cell.taskTextField.tag = indexPath.row
        cell.taskTextField.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as! TaskCell
        let selectedTask = self.allTasks[indexPath.row]
        
        // Toggle selection state of task
        selectedTask.isSelected = !selectedTask.isSelected
        if selectedTask.isSelected {
            if !self.activeTasks.contains(indexPath.row) {
                self.activeTasks.append(indexPath.row)
            }
        } else {
            if let activeTaskIndex = self.activeTasks.index(of: indexPath.row) {
                self.activeTasks.remove(at: activeTaskIndex)
            }
        }
        
        self.activeTasks.sort()
        selectedCell.isSelected = false
        checkActiveTask()
        tasksTableView.reloadData()
        saveTasks()
    }
    
}

//MARK: UITextField extension
extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("Done editing in cell \(textField.tag)")
        let editedTaskIndex = textField.tag
        guard let newText = textField.text else { return false }
        if newText != allTasks[editedTaskIndex].text && newText != "" {
            allTasks[editedTaskIndex].text = newText
            saveTasks()
        } else {
           textField.text = allTasks[editedTaskIndex].text
        }
        return true
    }
}
