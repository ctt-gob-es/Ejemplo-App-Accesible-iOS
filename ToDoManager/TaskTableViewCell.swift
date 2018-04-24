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
    
    weak var task: Task?
     var position: IndexPath?
     var taskListDelegate: TaskListDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteTask(_ sender: Any) {
        let dialog = UIAlertController(title: NSLocalizedString("cancelDialog.title", comment: ""), message: NSLocalizedString("cancelDialog.message", comment: ""), preferredStyle: .alert)
        let ok = UIAlertAction(title: NSLocalizedString("yesButton", comment: ""), style:.default, handler: {(action) -> Void in
            self.task!.cancel()
            self.taskListDelegate!.updateTask(task: self.task!, position: self.position!)
        })
        let cancel = UIAlertAction(title: NSLocalizedString("noButton", comment: ""), style: .cancel, handler: {(action) -> Void in
            //Nothing to do.
        })
        dialog.addAction(ok)
        dialog.addAction(cancel)
        self.window?.rootViewController?.present(dialog, animated: true, completion: nil)
    }
    
    @IBAction func completeTask(_ sender: Any) {
        let dialog = UIAlertController(title: NSLocalizedString("completeDialog.title", comment: ""), message: NSLocalizedString("completeDialog.message", comment: ""), preferredStyle: .alert)
        let ok = UIAlertAction(title: NSLocalizedString("yesButton", comment: ""), style:.default, handler: {(action) -> Void in
            self.task!.complete()
            self.taskListDelegate!.updateTask(task: self.task!, position: self.position!)
        })
        let cancel = UIAlertAction(title: NSLocalizedString("noButton", comment: ""), style: .cancel, handler: {(action) -> Void in
            //Nothing to do.
        })
        dialog.addAction(ok)
        dialog.addAction(cancel)
        self.window?.rootViewController?.present(dialog, animated: true, completion: nil)
        
    }
    
}
