//
//  DeadlineController.swift
//  ToDoManager
//
//  Created by DCC on 17/1/18.
//  Copyright © 2018 DCC. All rights reserved.
//

import Foundation
import UIKit

class DeadlineController: UIViewController {
    
    // MARK: properties
    
    @IBOutlet weak var deadlineField: UIDatePicker!
    
    var task: Task?
    var delegate: EditTaskDelegate?
    
    func configureView() {
        deadlineField.minimumDate = Date()
        if let deadline = task!.deadline as? Date{
            deadlineField.date = deadline
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
        delegate?.previousStep()
    }
    
    @IBAction func finishPressed(_ sender: Any) {
        task!.deadline = deadlineField.date
        navigationController?.isNavigationBarHidden = false
        delegate?.finish(task: task!)
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        navigationController?.isNavigationBarHidden = false
        delegate?.cancel()
    }
}
