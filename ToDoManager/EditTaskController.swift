//
//  EditTaskController.swift
//  ToDoManager
//
//  Created by DCC on 17/1/18.
//  Copyright © 2018 DCC. All rights reserved.
//

import Foundation
import UIKit

class EditTaskController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet var titleField: UIView!
    
    
    @IBOutlet weak var priorityField: UIPickerView!
    
    
    @IBOutlet weak var descriptionField: UITextView!
    
    
    @IBOutlet weak var complexField: UISwitch!
    
    
    @IBOutlet weak var deadlineField: UISwitch!
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var finishButton: UIButton!
    
    @IBAction func deadlineChanged(_ sender: Any) {
    }
    
    @IBAction func nextPressed(_ sender: Any) {
    }
    
    @IBAction func finishPressed(_ sender: Any) {
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
    }
    
}
