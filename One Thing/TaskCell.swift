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
    @IBOutlet weak var checkmarkButton: UIButton!
    @IBOutlet weak var arrowButton: UIButton!
    
    var task: Task! {
        didSet {
            self.taskTextField.text = task.text
            if task.isSelected { self.isSelected = true }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
