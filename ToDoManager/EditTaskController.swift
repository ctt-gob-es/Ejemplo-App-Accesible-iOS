//
//  EditTaskController.swift
//  ToDoManager
//
//  Created by DCC on 17/1/18.
//  Copyright © 2018 DCC. All rights reserved.
//

import Foundation
import UIKit

class EditTaskController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, EditTask {
    
    // MARK: Properties
    

    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var priorityField: UIPickerView!
    
    @IBOutlet weak var descriptionField: UITextView!
    
    @IBOutlet weak var complexField: UISwitch!
    
    @IBOutlet weak var deadlineField: UISwitch!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var finishButton: UIButton!
    
    var task: Task?
    var pos: IndexPath?
    let data = [NSLocalizedString("highPriority", comment: ""), NSLocalizedString("mediumPriority", comment: ""), NSLocalizedString("lowPriority", comment: "")]
    
    func configureView() {
        titleField.text = task!.name
        priorityField.selectRow(task!.priority, inComponent: 0, animated: false)
        descriptionField.text = task!.details
        complexField.setOn(task!.complex, animated: false)
        deadlineField.setOn(task!.deadline != nil, animated: false)
        if deadlineField.isOn {
            nextButton.isHidden = false
            finishButton.isHidden = true
        } else {
            nextButton.isHidden = true
            finishButton.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        priorityField.dataSource = self
        priorityField.delegate = self
        configureView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleField.accessibilityLabel = NSLocalizedString("ktD-cR-zOp.text", comment: "Same as title label.")
        priorityField.accessibilityLabel = NSLocalizedString("ibC-Z4-iZY.text", comment: "Same as priority label.")
        descriptionField.accessibilityLabel = NSLocalizedString("tFn-fA-zV4.text", comment: "Same as description label.")
        complexField.accessibilityLabel = NSLocalizedString("q89-Gv-Zik.text", comment: "Same as complex label.")
        deadlineField.accessibilityLabel = NSLocalizedString("fp9-Y0-WVn.text", comment: "Same as deadline label.")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "setDeadline" {
            let controller = segue.destination as! DeadlineController
            controller.task = task
            controller.pos = pos
        } else if segue.identifier == "finish" {
            updateTask()
        }
    }
    
    func updateTask() {
        task!.name = titleField.text!
        let row = priorityField.selectedRow(inComponent: 0)
        task!.priority = row
        task!.details = descriptionField.text
        task!.complex = complexField.isOn
        if !deadlineField.isOn {
            task!.deadline = nil
        }
    }
    
    @IBAction func deadlineChanged(_ sender: Any) {
        if deadlineField.isOn {
            nextButton.isHidden = false
            finishButton.isHidden = true
        } else {
            nextButton.isHidden = true
            finishButton.isHidden = false
        }
    }
    
    func validForm() -> Bool {
        if titleField.text?.isEmpty == true {
            return false
        } else {
            return true
        }
    }
    
    func invalidForm(sender: Any) {
        let dialog = UIAlertController(title: NSLocalizedString("editErrorTitle", comment: ""), message: NSLocalizedString("editErrorMessage", comment: ""), preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: NSLocalizedString("okButton", comment: ""), style:.default, handler: {(action) -> Void in
            //Nothing to do.
        })
        dialog.addAction(ok)
        dialog.modalPresentationStyle = .popover
        let popOver = dialog.popoverPresentationController
        popOver?.sourceView = sender as? UIButton
        self.present(dialog, animated: true, completion: nil)
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        if validForm() {
        updateTask()
        performSegue(withIdentifier: "setDeadline", sender: self)
        } else {
            invalidForm(sender: nextButton)
        }
    }
    
      func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    @IBAction func previous(unwindSegue: UIStoryboardSegue) {
        if let deadline = unwindSegue.source as? DeadlineController {
            task = deadline.task
            configureView()
        }
    }
    
    @IBAction func finishPressed(_ sender: Any) {
        if validForm() {
            updateTask()
            performSegue(withIdentifier: "finish", sender: self)
        } else {
            invalidForm(sender: nextButton)
        }
    }
    
}
