//
//  TaskCell.swift
//  One Thing
//
//  Created by Robert Hatfield on 5/31/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var taskImageView: UIImageView!
    
    var task: Task! {
        didSet {
            self.taskTextField.text = task.text
            if task.isSelected { self.isSelected = true }
            if task.isCurrent { self.taskImageView.image = #imageLiteral(resourceName: "task_active") }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        if selected {
            self.taskImageView.image = #imageLiteral(resourceName: "task_selected")
        } else {
            self.taskImageView.image = #imageLiteral(resourceName: "task_default")
        }
        self.task.isSelected = selected
        print("Cell selected: ")
    }
    
    //MARK: User actions
    
    @IBAction func arrowPressed(_ sender: UIButton) {
        print("Arrow pressed")
    }
    
    @IBAction func checkmarkPressed(_ sender: UIButton) {
        print("Checkmark pressed")
    }
}
