//
//  ViewController.swift
//  One Thing
//
//  Created by Robert Hatfield on 5/31/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var tasksTableView: UITableView!
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    
    //MARK: Properties
    var allTasks = [Task]() {
        didSet {
            self.tasksTableView.reloadData()
        }
    }
    var activeTasks = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tasksTableView.dataSource = self
        self.tasksTableView.delegate = self
        let taskNib = UINib(nibName: "TaskCell", bundle: nil)
        self.tasksTableView.register(taskNib, forCellReuseIdentifier: TaskCell.identifier)
        self.tasksTableView.estimatedRowHeight = 50
        self.tasksTableView.rowHeight = UITableViewAutomaticDimension
    }

    func checkActiveTask() {
        guard let indexPaths = self.tasksTableView.indexPathsForVisibleRows else { return }
        
        // Reset activeTasks array; row assignments have changed
        self.activeTasks.removeAll()
        var index = 0
            for task in allTasks {
                if task.isSelected {
                    self.activeTasks.append(index)
                }
            index += 1
        }
        
        for indexPath in indexPaths {
            let cell = tasksTableView.cellForRow(at: indexPath) as! TaskCell
            
            switch self.allTasks[indexPath.row].isSelected {
            case true:
                if indexPath.row == self.activeTasks.last {
                    cell.taskImageView.image = #imageLiteral(resourceName: "task_active")
                } else {
                    cell.taskImageView.image = #imageLiteral(resourceName: "task_selected")
                }
            case false:
                cell.taskImageView.image = #imageLiteral(resourceName: "task_default")
            }
            
        }
        print(activeTasks)
    }
    
    //MARK: User actions
    func taskCompleted(sender: UIButton) {
        print("Task completed for index \(sender.tag)")
        allTasks.remove(at: sender.tag)
        self.tasksTableView.reloadData()
        checkActiveTask()
    }
    
    func taskWorked(sender: UIButton) {
        print("Task \(sender.tag) worked, move to end")
        self.allTasks[sender.tag].isSelected = false
        allTasks.append(allTasks.remove(at: sender.tag))
        if let oldIndex = self.activeTasks.index(of: sender.tag) {
            self.activeTasks.remove(at: oldIndex)
        }
        self.tasksTableView.reloadData()
        checkActiveTask()
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
        if task.isSelected {
            cell.setSelected(true, animated: false)
        }
        if self.activeTasks.last == indexPath.row {
            cell.taskImageView.image = #imageLiteral(resourceName: "task_active")
        }
        
        cell.checkmarkButton.tag = indexPath.row
        cell.checkmarkButton.addTarget(self, action: #selector(ViewController.taskCompleted), for: UIControlEvents.touchUpInside)
        
        cell.arrowButton.tag = indexPath.row
        cell.arrowButton.addTarget(self, action: #selector(ViewController.taskWorked), for: UIControlEvents.touchUpInside)
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
    }
    
}

//MARK: UITextField extension
extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("Done editing")
        return true
    }
}
