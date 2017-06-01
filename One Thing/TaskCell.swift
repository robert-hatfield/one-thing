//
//  TaskCell.swift
//  One Thing
//
//  Created by Robert Hatfield on 5/31/17.
//  Copyright © 2017 Robert Hatfield. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var taskTextView: UITextView!
    @IBOutlet weak var selectButton: UIButton!
    
    var task: Task! {
        didSet {
            self.taskTextView.text = task.text
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

        // Configure the view for the selected state
    }
    
    //MARK: User actions
    @IBAction func selectPressed(_ sender: UIButton) {
    }
    
    @IBAction func arrowPressed(_ sender: UIButton) {
    }
    
    @IBAction func checkmarkPressed(_ sender: UIButton) {
    }
}
