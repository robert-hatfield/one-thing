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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tasksTableView.dataSource = self
        self.tasksTableView.delegate = self
        let taskNib = UINib(nibName: "TaskCell", bundle: nil)
        self.tasksTableView.register(taskNib, forCellReuseIdentifier: TaskCell.identifier)
        self.tasksTableView.estimatedRowHeight = 50
        self.tasksTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    //MARK: User actions
    @IBAction func addTaskPressed(_ sender: UIButton) {
        let newTask = Task(text: "")
        self.tasksTableView.beginUpdates()
        self.allTasks.append(newTask)
        
        let lastRow = self.tasksTableView.numberOfRows(inSection: 0)
        let lastIndexPath = IndexPath(row: lastRow, section: 0)
        
        
        self.tasksTableView.insertRows(at: [lastIndexPath], with: UITableViewRowAnimation.automatic)
        
        self.tasksTableView.endUpdates()
        self.tasksTableView.selectRow(at: lastIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.top)
        let newCell = self.tasksTableView.cellForRow(at: lastIndexPath) as! TaskCell
        newCell.taskTextField.delegate = self
        newCell.taskTextField.becomeFirstResponder()
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as! TaskCell
        selectedCell.task.isSelected = true
        selectedCell.taskImageView.image = #imageLiteral(resourceName: "task_selected")
        print("Cell selected in delegate method")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deselectedCell = tableView.cellForRow(at: indexPath) as! TaskCell
        deselectedCell.task.isSelected = false
        deselectedCell.taskImageView.image = #imageLiteral(resourceName: "task_default")
        print("Cell DEselected in delegate method")

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
