//
//  TodoList.swift
//  ToDoManager
//
//  Created by DCC on 16/11/17.
//  Copyright © 2017 DCC. All rights reserved.
//

import Foundation

class Task: NSCopying {
    static let HIGH_PRIORITY = 0
    static let MEDIUM_PRIORITY = 1
    static let LOW_PRIORITY = 2
    var id: Int = 0
    var name="", details=""
    var priority=Task.MEDIUM_PRIORITY
    var complex: Bool = false
    var completed: Int = 0
    var deadline: Date?
    var status: TaskStatus = PendingTask()
    
    init?(name: String, details: String, priority: Int, complex: Bool, deadline: Date?) {
        id = 0
        if name.isEmpty {
            return nil
        }
            self.name = name
        self.details = details
        if (priority != Task.HIGH_PRIORITY && priority != Task.MEDIUM_PRIORITY && priority != Task.LOW_PRIORITY) {
            return nil
        }
        self.priority = priority
        self.complex = complex
        completed = 0
        self.deadline = deadline
        status = PendingTask()
    }
    
    func complete() {
        status.completeTask(task: self)
    }
    
    func cancel() {
        status.cancelTask(task: self)
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let t = Task(name: self.name, details: self.details, priority: self.priority, complex: self.complex, deadline: self.deadline)
        if let copy = t {
            copy.id = self.id
            copy.completed = self.completed
            copy.status = self.status
            return copy
        } else {
            preconditionFailure("The original object is invalid.")
        }
    }
    
}

class TaskStatus {
    var statusDescription: String {
        get {
            return ""
        }
    }
    func completeTask(task: Task) {
        preconditionFailure("This method must be overriden.")
    }
    func cancelTask(task: Task) {
        preconditionFailure("This method must be overriden.")
    }
}

class PendingTask: TaskStatus {
    override var statusDescription: String {
        get {
            return "PENDING_TASK"
        }
    }
    override func completeTask(task:Task) {
        task.status = CompletedTask()
    }
    
    override func cancelTask(task: Task) {
        task.status = CanceledTask()
    }
}

class CompletedTask: TaskStatus {
    override var statusDescription: String {
        get {
            return "COMPLETED_TASK"
        }
    }
    override func completeTask(task: Task) {
        preconditionFailure("This task cannot change its status.")
    }
    
    override func cancelTask(task: Task) {
        preconditionFailure("This task cannot change its status.")
    }
}

class CanceledTask: TaskStatus {
    override var statusDescription: String {
        get {
            return "CANCELED_TASK"
        }
    }
    override func completeTask(task: Task) {
        preconditionFailure("This task cannot change its status.")
    }
    
    override func cancelTask(task: Task) {
        preconditionFailure("This task cannot change its status.")
    }
}

class TaskList {
    
    var taskCount = 0
    var tasks = [Int: Task]()
    var list = [Task]()
    
    func getTask(id: Int) -> Task? {
        return tasks[id]
    }
    
    func getTask(pos: Int) -> Task? {
        return list[pos]
    }
    
    func count() -> Int {
        return list.count
    }
    
    func addTask(_ task: Task) {
        task.id = taskCount
        tasks[task.id] = task
        list.append(task)
        taskCount += 1
    }

    func setTask(task: Task) -> Bool {
        if tasks[task.id] != nil {
            tasks[task.id] = task
            for (index, value) in list.enumerated() {
                if value.id == task.id {
                    list[index] = task
                    return true
                }
            }
                return false
        } else {
            return false
        }
    }
    
    func fillDefault() {
        let t1 = Task(name: "Pasear al perro", details: "Sacar al perro a pasear antes de desayunar.", priority: Task.MEDIUM_PRIORITY,
                      complex: false, deadline: nil)
        let t2 = Task(name: "Estudiar para examen", details: "Estudiar para el examen de historia de la semana que viene.", priority: Task.HIGH_PRIORITY, complex: true, deadline: Date(timeIntervalSinceNow: 600000))
        let t3 = Task(name: "Regalo Ana", details: "Comprar el regalo de cumpleaños para Ana.", priority: Task.MEDIUM_PRIORITY, complex: false, deadline: Date(timeIntervalSinceNow: 900000))
        let t4 = Task(name: "Star wars", details: "Ir a ver Star Wars al cine", priority: Task.LOW_PRIORITY, complex: false, deadline: nil)
            addTask(t1!)
            addTask(t2!)
            addTask(t3!)
            addTask(t4!)
    }
    
}
