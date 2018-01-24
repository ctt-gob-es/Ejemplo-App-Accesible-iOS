//
//  DetailViewController.swift
//  ToDoManager
//
//  Created by DCC on 16/11/17.
//  Copyright © 2017 DCC. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, EditTaskDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var priorityLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var deadlineLabel: UILabel!
    
    @IBOutlet weak var completionLabel: UILabel!
    
    @IBOutlet weak var completionSlider: UISlider!

    var position: IndexPath?
     var detailItem: Task? {
        didSet {
            // Update the view.
            if self.isViewLoaded {
                configureView()
            }
        }
    }
    var taskListDelegate: TaskListDelegate?
    
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
        if let st = detailItem?.status as? CompletedTask {
            navigationItem.rightBarButtonItems = []
            completionSlider.isHidden = true
            completionLabel.isHidden = true
        } else if let st = detailItem?.status as? CanceledTask {
            navigationItem.rightBarButtonItems = []
            completionSlider.isHidden = true
            completionLabel.isHidden = true
        }
        else if detailItem!.complex {
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
        // Do any additional setup after loading the view, typically from a nib
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTask(_:)))
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTask(_:)))
        let completeButton = UIBarButtonItem(barButtonSystemItem: .done,  target: self, action: #selector(completeTask(_:)))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTask(_:)))

        navigationItem.leftBarButtonItems = [saveButton]
        navigationItem.rightBarButtonItems = [editButton, cancelButton, completeButton]
        configureView()
    }

  	  override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func cancelTask(_ sender: Any) {
        let dialog = UIAlertController(title: "Confirm", message: "Are you sure you want to cancel this task?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Yes", style:.default, handler: {(action) -> Void in
            self.detailItem!.cancel()
            self.configureView()
        })
        let cancel = UIAlertAction(title: "No", style: .cancel, handler: {(action) -> Void in
            //Nothing to do.
        })
        dialog.addAction(ok)
        dialog.addAction(cancel)
        self.present(dialog, animated: true, completion: nil)
    }

    @objc func completeTask(_ sender: Any) {
        let dialog = UIAlertController(title: "Confirm", message: "Are you sure you want to complete this task?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Yes", style:.default, handler: {(action) -> Void in
            self.detailItem!.complete()
            self.configureView()
        })
        let cancel = UIAlertAction(title: "No", style: .cancel, handler: {(action) -> Void in
            //Nothing to do.
        })
        dialog.addAction(ok)
        dialog.addAction(cancel)
        self.present(dialog, animated: true, completion: nil)
    }

    @objc func editTask(_ sender: Any) {
        
    }
    
    @objc func saveTask(_ sender: Any) {
        taskListDelegate?.updateTask(task: self.detailItem!, position: self.position!)
        navigationController?.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func completionChanged(_ sender: Any) {
        let completion = Int(self.completionSlider.value)
        if completion == 100 {
            let dialog = UIAlertController(title: "Confirm", message: "Are you sure you want to complete this task?", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Yes", style:.default, handler: {(action) -> Void in
                self.detailItem!.complete()
                self.configureView()
            })
            let cancel = UIAlertAction(title: "No", style: .cancel, handler: {(action) -> Void in
                self.completionSlider.value = 99
                            })
            dialog.addAction(ok)
            dialog.addAction(cancel)
            self.present(dialog, animated: true, completion: nil)
        }
    }
    
    func finish(task: Task) {
        self.detailItem = task
        navigationController?.navigationController?.popToViewController(self, animated: true)
    }
    
    func cancel() {
        navigationController?.navigationController?.popToViewController(self, animated: true)
    }
    
}

