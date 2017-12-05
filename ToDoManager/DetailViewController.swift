//
//  DetailViewController.swift
//  ToDoManager
//
//  Created by DCC on 16/11/17.
//  Copyright © 2017 DCC. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var priorityLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var deadlineLabel: UILabel!
    
    @IBOutlet weak var completionLabel: UILabel!
    
    @IBOutlet weak var completionSlider: UISlider!
    
    func configureView() {
        // Update the user interface for the detail item.
        titleLabel.text = "Title" + ": " + detailItem!.name
        switch detailItem!.priority {
        case Task.HIGH_PRIORITY: priorityLabel.text = "Priority" + ": " + "High"
        case Task.MEDIUM_PRIORITY: priorityLabel.text = "Priority" + ": " + "Medium"
        case Task.LOW_PRIORITY: priorityLabel.text = "Priority" + ": " + "Low"
        default: preconditionFailure("Task must not be nil.")
        }
        statusLabel.text = "Status" + ": " + detailItem!.status.statusDescription
        descriptionLabel.text = "Description" + ": " + detailItem!.details
        if detailItem!.deadline !=   nil {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            deadlineLabel.text = "Deadline" + ": " + formatter.string(from: detailItem!.deadline!)
            deadlineLabel.isHidden = false
        } else {
        deadlineLabel.isHidden = true
        }
        if detailItem!.complex {
            completionSlider.setValue(Float(detailItem!.completed), animated: false)
            completionLabel.isHidden = false
            completionSlider.isHidden = false
            // completionSlider.didChangeValue(for: <#T##KeyPath<UISlider, Value>#>)
        } else {
            completionSlider.isHidden = true
            completionLabel.isHidden = true
        }
     }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Task? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    
    @IBAction func deleteTask(_ sender: Any) {
    }
    

    @IBAction func completeTask(_ sender: Any) {
    }
}

