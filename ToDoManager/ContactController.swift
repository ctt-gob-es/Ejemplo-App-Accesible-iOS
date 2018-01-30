//
//  ContactController.swift
//  ToDoManager
//
//  Created by DCC on 26/1/18.
//  Copyright © 2018 DCC. All rights reserved.
//

import Foundation
import UIKit

class ContactController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var messageField: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let sendButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(send(_:)))
        navigationItem.rightBarButtonItem = sendButton
    }
    
    @objc
    func send(_ sender: Any) {
        let dialog = UIAlertController(title: "Confirm", message: "Are you sure you want to send this message to our support team?", preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "Yes", style:.default, handler: {(action) -> Void in
            self.navigationController?.navigationController?.popToRootViewController(animated: true)
        })
        let cancel = UIAlertAction(title: "No", style: .cancel, handler: {(action) -> Void in
            //Nothing to do.
        })
        dialog.addAction(ok)
        dialog.addAction(cancel)
        self.present(dialog, animated: true, completion: nil)
    }

    
}
