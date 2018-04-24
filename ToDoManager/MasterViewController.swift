//
//  MasterViewController.swift
//  ToDoManager
//
//  Created by DCC on 16/11/17.
//  Copyright © 2017 DCC. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, TaskListDelegate {

    var detailViewController: DetailViewController? = nil
    var objects = TaskList()
    var tasks: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize the task list.
        objects.fillDefault()
        
        //Register the settings bundle and add an observer to check if defaults changed
        registerSettingsBundle()
        NotificationCenter.default.addObserver(self, selector: #selector(MasterViewController.defaultsChanged), name: UserDefaults.didChangeNotification, object: nil)
        defaultsChanged()
        
        // Do any additional setup after loading the view, typically from a nib.
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        addButton.accessibilityHint = NSLocalizedString("addTaskHint", comment: "")
        let optionsButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showOptionsMenu(_:)))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = optionsButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
            detailViewController?.detailItem = tasks[0]
            detailViewController?.position = IndexPath(row: 0, section: 0)
            detailViewController?.taskListDelegate = self
            detailViewController?.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            detailViewController?.navigationItem.leftItemsSupplementBackButton = true
                    }
    }
    
    func registerSettingsBundle(){
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
    }
    @objc func defaultsChanged(){
        reloadTasks()
    }

    func filter() {
        //Hide completed tasks switch and hide canceled tasks switch
        let hideCompleted = UserDefaults.standard.bool(forKey: "hide_completed_tasks_preference")
        let hideCanceled = UserDefaults.standard.bool(forKey: "hide_canceled_tasks_preference")
        if hideCompleted && hideCanceled {
            tasks = objects.list.filter({t in t.status is PendingTask})
        }
        else if hideCompleted {
            tasks = objects.list.filter({t in !(t.status is CompletedTask)})
        }
        else if hideCanceled {
            tasks = objects.list.filter({t in !(t.status is CanceledTask)})
        }
        else {
            tasks = objects.list
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
    }
    
	    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc
    func insertNewObject(_ sender: Any) {
        performSegue(withIdentifier: "createTask", sender: self)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = tasks[indexPath.row]
                let o = object.copy() as! Task
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = o
                controller.position = indexPath
                controller.taskListDelegate = self
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                    detailViewController = controller
            }
        } else if segue.identifier == "createTask" {
            let controller = segue.destination as! EditTaskController
            controller.task = Task()
        }
    }

    @objc
    func showOptionsMenu(_ sender: Any) {
        let dialog = UIAlertController(title: "Options", message: "Choose an option...", preferredStyle: .actionSheet)
        let preferences = UIAlertAction(title: "Preferences", style: .default, handler: {(action) -> Void in
            UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!)
        })
        let help = UIAlertAction(title: "Help", style:.default, handler: {(action) -> Void in
            self.performSegue(withIdentifier: "showHelp", sender: self)
        })
        let contact = UIAlertAction(title: "Contact us", style: .default, handler: {(action) -> Void in
            self.performSegue(withIdentifier: "showContactForm", sender: self)
        })
        let cancel = UIAlertAction(title: "Close", style: .cancel, handler: {(action) -> Void in
            //Nothing to do.
        })
        
        dialog.addAction(preferences)
        dialog.addAction(help)
        dialog.addAction(contact)
        dialog.addAction(cancel)
        dialog.modalPresentationStyle = .popover
         let popOver = dialog.popoverPresentationController
     popOver?.barButtonItem = navigationItem.leftBarButtonItem
        
        self.present(dialog, animated: true, completion: nil)
    }

    
    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as? TaskTableViewCell else {
            fatalError("The cell is not an instance of TaskTableViewCell.")
        }

        let task = tasks[indexPath.row]
        cell.task = task
        cell.taskListDelegate = self
        cell.position = indexPath
        
        // Initialization code
        cell.taskName.text = task.name
        switch task.priority {
        case Task.HIGH_PRIORITY: cell.taskName.textColor = UIColor.red
        case Task.MEDIUM_PRIORITY: cell.taskName.textColor = UIColor.blue
        case Task.LOW_PRIORITY: cell.taskName.textColor = UIColor.magenta
        default: cell.taskName.textColor = UIColor.blue
        }
        if  task.status is CompletedTask {
            cell.deleteButton.isHidden = true
            cell.completeButton.isHidden = true
            cell.taskName.textColor = UIColor.green
        }
        else if  task.status is CanceledTask {
            cell.deleteButton.isHidden = true
            cell.completeButton.isHidden = true
            cell.taskName.textColor = UIColor.gray
        }
        if task.deadline != nil {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            cell.deadline.text = formatter.string(from: task.deadline!)
        } else {
            cell.deadline.text = ""
        }
        cell.completeButton.accessibilityLabel = NSLocalizedString("completeButton.label", comment: "")
        cell.completeButton.accessibilityHint = NSLocalizedString("completeButton.hint", comment: "")
        cell.deleteButton.accessibilityLabel = NSLocalizedString("cancelButton.label", comment: "")
        cell.deleteButton.accessibilityHint = NSLocalizedString("cancelButton.hint", comment: "")
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // objects.remove(at: indexPath.row)
            // tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

     func updateTask(task: Task, position pos: IndexPath) {
        let updated = self.objects.setTask(task: task)
        if updated {
        reloadTasks()
            /* if splitViewController != nil {
                self.tableView.selectRow(at: pos, animated: true, scrollPosition: .middle)
                performSegue(withIdentifier: "showDetail", sender: nil)
        } */
        }
        }
    
     func insertTask(task: Task) {
        self.objects.addTask(task)
        filter()
        self.tableView.reloadData()
    }
    
     func reloadTasks() {
        filter()
        self.tableView.reloadData()
    }
    
    @IBAction func finish(unwindSegue: UIStoryboardSegue) {
        if let edit = unwindSegue.source as? EditTask {
            detailViewController?.detailItem = edit.task
            if edit.pos == nil {
                detailViewController?.position = IndexPath(row: tableView.numberOfRows(inSection: 0) - 1, section: 0)
                insertTask(task: edit.task!)
            } else {
                updateTask(task: edit.task!, position: edit.pos!)
                detailViewController?.position = edit.pos
            }
            detailViewController?.configureView()
        }
    }
    
    @IBAction func cancel(unwindSegue: UIStoryboardSegue) {
        // Nothing to do.
    }
}


