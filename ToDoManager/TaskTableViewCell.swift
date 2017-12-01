//
//  TaskTableViewCell.swift
//  ToDoManager
//
//  Created by DCC on 29/11/17.
//  Copyright © 2017 DCC. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var taskName: UILabel!
    
    @IBOutlet weak var deadline: UILabel!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var modifyButton: UIButton!
    
    var task: Task
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        taskName.text = task.name
        switch task.priority {
        case Task.HIGH_PRIORITY: taskName.textColor = UIColor.red()
        case Task.MEDIUM_PRIORITY: taskName.textColor = UIColor.blue()
        case Task.LOW_PRIORITY: taskName.textColor = UIColor.magenta()        }
        if task.deadline != nil {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            deadline.text = formatter.string(from: task.deadline)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
