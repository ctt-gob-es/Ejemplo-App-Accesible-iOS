//
//  DeadlineController.swift
//  ToDoManager
//
//  Created by DCC on 17/1/18.
//  Copyright © 2018 DCC. All rights reserved.
//

import Foundation
import UIKit

class DeadlineController: UIViewController, EditTask {
    
    // MARK: properties
    
    @IBOutlet weak var deadlineField: UIDatePicker!
    
    var task: Task?
    var pos: IndexPath?

    func configureView() {
        deadlineField.minimumDate = Date()
        if task!.deadline != nil {
            deadlineField.date = task!.deadline!
        } else {
            deadlineField.date = Date(timeIntervalSinceNow: 1)
        }
    }
    
    override func viewDidLoad() {
        configureView()
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func deadlineChanged(_ sender: Any) {
    }
    
    @IBAction func previousPressed(_ sender: Any) {
        navigationController?.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func finishPressed(_ sender: Any) {
        task!.deadline = deadlineField.date
        navigationController?.isNavigationBarHidden = false
        
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        navigationController?.isNavigationBarHidden = false
        
    }}
