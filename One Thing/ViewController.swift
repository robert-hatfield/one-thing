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
    var activeTaskIndex : Int?

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
        for indexPath in indexPaths {
            let cell = tasksTableView.cellForRow(at: indexPath) as! TaskCell
            
            switch self.allTasks[indexPath.row].isSelected {
            case true:
                if indexPath.row == self.activeTaskIndex || self.activeTaskIndex == nil {
                    cell.taskImageView.image = #imageLiteral(resourceName: "task_active")
                } else {
                    cell.taskImageView.image = #imageLiteral(resourceName: "task_selected")
                }
            case false:
                cell.taskImageView.image = #imageLiteral(resourceName: "task_default")
            }
            
        }
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
        if self.activeTaskIndex == indexPath.row {
            cell.taskImageView.image = #imageLiteral(resourceName: "task_active")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as! TaskCell
        selectedCell.task.isSelected = true
        selectedCell.taskImageView.image = #imageLiteral(resourceName: "task_selected")
        self.allTasks[indexPath.row].isSelected = true
        if self.activeTaskIndex == nil || indexPath.row > self.activeTaskIndex! {
            activeTaskIndex = indexPath.row
        }
        print("Cell selected in delegate method")
        checkActiveTask()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deselectedCell = tableView.cellForRow(at: indexPath) as! TaskCell
        deselectedCell.task.isSelected = false
        deselectedCell.taskImageView.image = #imageLiteral(resourceName: "task_default")
        self.allTasks[indexPath.row].isSelected = false
        
        // reset task index
        var index = 0
        self.activeTaskIndex = nil
        for task in allTasks {
            if task.isSelected {
                self.activeTaskIndex = index
            }
            index += 1
        }
        print("Cell DEselected in delegate method")
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
