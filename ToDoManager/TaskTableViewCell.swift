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
    
    @IBOutlet weak var completeButton: UIButton!
    
    var task: Task?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        taskName.text = task!.name
        switch task!.priority {
        case Task.HIGH_PRIORITY: taskName.textColor = UIColor.red
        case Task.MEDIUM_PRIORITY: taskName.textColor = UIColor.blue
        case Task.LOW_PRIORITY: taskName.textColor = UIColor.magenta
            default: taskName.textColor = UIColor.blue
        }
        if let st = task!.status as? CompletedTask {
            deleteButton.isHidden = true
            completeButton.isHidden = true
                taskName.textColor = UIColor.green
                    }
        else if let st = task!.status as? CanceledTask {
            deleteButton.isHidden = true
            completeButton.isHidden = true
            taskName.textColor = UIColor.gray
        }
        if task!.deadline != nil {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            deadline.text = formatter.string(from: task!.deadline!)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteTask(_ sender: Any) {
        let dialog = UIAlertController(title: "Confirm", message: "Are you sure you want to cancel this task?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Yes", style:.default, handler: {(action) -> Void in
            self.task!.complete()
        })
        let cancel = UIAlertAction(title: "No", style: .cancel, handler: {(action) -> Void in
            //Nothing to do.
        })
        dialog.addAction(ok)
        dialog.addAction(cancel)
        self.window?.rootViewController?.present(dialog, animated: true, completion: nil)
    }
    
    
    @IBAction func completeTask(_ sender: Any) {
        let dialog = UIAlertController(title: "Confirm", message: "Are you sure you want to complete this task?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Yes", style:.default, handler: {(action) -> Void in
            self.task!.cancel()
        })
        let cancel = UIAlertAction(title: "No", style: .cancel, handler: {(action) -> Void in
            //Nothing to do.
        })
        dialog.addAction(ok)
        dialog.addAction(cancel)
        self.window?.rootViewController?.present(dialog, animated: true, completion: nil)
    }
    

}
