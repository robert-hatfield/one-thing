//
//  ViewController.swift
//  One Thing
//
//  Created by Robert Hatfield on 5/31/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tasksTableView: UITableView!
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    
    var allTasks = [Task]() {
        didSet {
            self.tasksTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tasksTableView.dataSource = self
        let taskNib = UINib(nibName: "TaskCell", bundle: nil)
        self.tasksTableView.register(taskNib, forCellReuseIdentifier: TaskCell.identifier)
        self.tasksTableView.estimatedRowHeight = 50
        self.tasksTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as! TaskCell
        let task = self.allTasks[indexPath.row]
        cell.task = task
        return cell
    }
    
    @IBAction func addTaskPressed(_ sender: UIButton) {
        var newTask = Task(text: "")
        self.tasksTableView.beginUpdates()
        self.allTasks.append(newTask)
        
        let lastRow = self.tasksTableView.numberOfRows(inSection: 0)
        let lastIndexPath = IndexPath(row: lastRow, section: 0)
        
        
        self.tasksTableView.insertRows(at: [lastIndexPath], with: UITableViewRowAnimation.automatic)
        
        self.tasksTableView.endUpdates()
        self.tasksTableView.selectRow(at: lastIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.top)
        let newCell = self.tasksTableView.cellForRow(at: lastIndexPath) as! TaskCell
        newCell.taskTextField.becomeFirstResponder()
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as! TaskCell
        selectedCell.setSelected(true, animated: true)
        selectedCell.taskTextField.becomeFirstResponder()
    }
}
