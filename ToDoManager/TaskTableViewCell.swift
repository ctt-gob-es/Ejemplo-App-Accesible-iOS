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
    var tableView: UITableView?
    var position: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteTask(_ sender: Any) {
        let dialog = UIAlertController(title: "Confirm", message: "Are you sure you want to cancel this task?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Yes", style:.default, handler: {(action) -> Void in
            self.task!.cancel()
            if let position = self.position {
            self.tableView?.reloadRows(at: [position], with: UITableViewRowAnimation.automatic)
            }
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
            self.task!.complete()
            if let position = self.position {
            self.tableView?.reloadRows(at: [position], with: UITableViewRowAnimation.automatic)
            }
        })
        let cancel = UIAlertAction(title: "No", style: .cancel, handler: {(action) -> Void in
            //Nothing to do.
        })
        dialog.addAction(ok)
        dialog.addAction(cancel)
        self.window?.rootViewController?.present(dialog, animated: true, completion: nil)
        
    }

}
