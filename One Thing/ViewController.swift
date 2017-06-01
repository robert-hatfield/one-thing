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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addTaskPressed(_ sender: UIButton) {
    }
}

