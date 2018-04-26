//
//  HelpController.swift
//  ToDoManager
//
//  Created by DCC on 26/1/18.
//  Copyright © 2018 DCC. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class HelpController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var webContainer: WKWebView!
    let dir = "html/"
    let pathFile = NSLocalizedString("helpFilePath", comment: "The path changes for each language.")
    let ext = "html"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
        let htmlFile = Bundle.main.path(forResource: pathFile, ofType: ext, inDirectory: dir)
        let contents = try String(contentsOfFile: htmlFile!, encoding: String.Encoding.utf8)
        let baseUrl = URL(fileURLWithPath: htmlFile!)
        webContainer.loadHTMLString(contents, baseURL: baseUrl)
        } catch {
            // Nothing.
        }
}

}
