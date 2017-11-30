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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
