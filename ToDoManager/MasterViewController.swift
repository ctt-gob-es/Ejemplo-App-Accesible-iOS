//
//  MasterViewController.swift
//  ToDoManager
//
//  Created by DCC on 16/11/17.
//  Copyright © 2017 DCC. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, TaskListDelegate, EditTaskDelegate {

    var detailViewController: DetailViewController? = nil
    var objects = TaskList()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize the task list.
        objects.fillDefault()
        // Do any additional setup after loading the view, typically from a nib.
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
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
        performSegue(withIdentifier: "createTask", sender: nil)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects.getTask(pos: indexPath.row)!
                let o = object.copy() as! Task
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = o
                controller.position = indexPath
                controller.taskListDelegate = self
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        } else if segue.identifier == "createTask" {
            let controller = (segue.destination as! UINavigationController).topViewController as! EditTaskController
            controller.delegate = self
            controller.task = Task()
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as? TaskTableViewCell else {
            fatalError("The cell is not an instance of TaskTableViewCell.")
        }

        let task = objects.getTask(pos: indexPath.row)
        cell.task = task
        cell.taskListDelegate = self
        cell.position = indexPath
        
        // Initialization code
        cell.taskName.text = task!.name
        switch task!.priority {
        case Task.HIGH_PRIORITY: cell.taskName.textColor = UIColor.red
        case Task.MEDIUM_PRIORITY: cell.taskName.textColor = UIColor.blue
        case Task.LOW_PRIORITY: cell.taskName.textColor = UIColor.magenta
        default: cell.taskName.textColor = UIColor.blue
        }
        if let st = task!.status as? CompletedTask {
            cell.deleteButton.isHidden = true
            cell.completeButton.isHidden = true
            cell.taskName.textColor = UIColor.green
        }
        else if let st = task!.status as? CanceledTask {
            cell.deleteButton.isHidden = true
            cell.completeButton.isHidden = true
            cell.taskName.textColor = UIColor.gray
        }
        if task!.deadline != nil {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            cell.deadline.text = formatter.string(from: task!.deadline!)
        }
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
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [pos], with: UITableViewRowAnimation.automatic)
        self.tableView.endUpdates()
        }
        }
    
     func insertTask(task: Task) {
        self.objects.addTask(task)
        self.tableView.beginUpdates()
        self.tableView.reloadData()
        self.tableView.endUpdates()
    }
    
     func reloadTasks() {
        self.tableView.beginUpdates()
        self.tableView.reloadData()
        self.tableView.endUpdates()
    }

    func nextStep(task: Task) {
        
    }
    
    func previousStep() {
        navigationController?.popViewController(animated: true)
    }
    
    func finish(task: Task) {
        insertTask(task: task)
    }
    
    func cancel() {
        navigationController?.popToViewController(self, animated: true)
    }
}

