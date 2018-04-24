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
    }

    override func viewWillAppear(_ animated: Bool) {
        nameField.accessibilityLabel = NSLocalizedString("j0L-Dk-UVr.text", comment: "Same as nameLabel.")
        emailField.accessibilityLabel = NSLocalizedString("bQT-Ye-t6h.text", comment: "Same as emailLabel.")
        messageField.accessibilityLabel = NSLocalizedString("FGM-Dk-SJd.text", comment: "Same as messageLabel.")
    }
    
    func validForm()-> Bool {
        if !((nameField.text?.isEmpty == true) || (emailField.text?.isEmpty == true) || (messageField.text.isEmpty == true)) {
            return true
        } else {
            return false
        }
    }
    
    @IBAction func send(_ sender: Any) {
        if validForm() {
            let dialog = UIAlertController(title: NSLocalizedString("contactConfirmtitle", comment: ""), message: NSLocalizedString("contactConfirmMessage", comment: ""), preferredStyle: .actionSheet)
            let ok = UIAlertAction(title: NSLocalizedString("yesButton", comment: ""), style:.default, handler: {(action) -> Void in
                self.performSegue(withIdentifier: "close", sender: self)
            })
            let cancel = UIAlertAction(title: NSLocalizedString("noButton", comment: ""), style: .cancel, handler: {(action) -> Void in
                //Nothing to do.
            })
            dialog.addAction(ok)
            dialog.addAction(cancel)
            dialog.modalPresentationStyle = .popover
            let popOver = dialog.popoverPresentationController
            popOver?.sourceView = sender as? UIButton
            self.present(dialog, animated: true, completion: nil)
        } else {
            let dialog = UIAlertController(title: NSLocalizedString("contactErrorTitle", comment: ""), message: NSLocalizedString("contactErrorMessage", comment: ""), preferredStyle: .actionSheet)
            let ok = UIAlertAction(title: NSLocalizedString("okButton", comment: ""), style:.default, handler: {(action) -> Void in
                //Nothing to do.
            })
            dialog.addAction(ok)
            dialog.modalPresentationStyle = .popover
            let popOver = dialog.popoverPresentationController
            popOver?.sourceView = sender as? UIButton
            self.present(dialog, animated: true, completion: nil)
        }
        
    }
    
    
}
