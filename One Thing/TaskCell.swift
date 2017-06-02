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
    @IBOutlet weak var selectButton: UIButton!
    
    var task: Task! {
        didSet {
            self.taskTextField.text = task.text
            if task.isSelected { self.selectButton.isSelected = true }
            if task.isCurrent { self.selectButton.isHighlighted = true }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.selectButton.imageView?.image = #imageLiteral(resourceName: "task_selected")
    }
    
    //MARK: User actions
    @IBAction func selectPressed(_ sender: UIButton) {
        self.setSelected(true, animated: true)
        self.task.isSelected = true
    }
    
    @IBAction func arrowPressed(_ sender: UIButton) {
    }
    
    @IBAction func checkmarkPressed(_ sender: UIButton) {
    }
}
