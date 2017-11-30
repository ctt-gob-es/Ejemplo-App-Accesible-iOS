//
//  TodoList.swift
//  ToDoManager
//
//  Created by DCC on 16/11/17.
//  Copyright © 2017 DCC. All rights reserved.
//

import Foundation

class Task {
    static let HIGH_PRIORITY = 3
    static let MEDIUM_PRIORITY = 2
    static let LOW_PRIORITY = 1
    var id: Int = 0
    var name="", details=""
    var priority=Task.MEDIUM_PRIORITY
    var complex: Bool = false
    var completed: Int = 0
    var deadline: Date?
    var status: TaskStatus = PendingTask()
    
    init(?name: String, details: String, priority: Int, complex: Bool, deadline: Date) {
        id = 0
        if (name == nil | name == nil) return nil
            self.name = name
        if (details == nil) return nil
        self.details = details
        if (priority == nil) return nil
        if (priority != Task.HIGH_PRIORITY & priority != Task.MEDIUM_PRIORITY & priority != Task.LOW_PRIORITY) return nil
        self.priority = priority
        if (complex == nil) return nil
        self.complex = complex
        completed = 0
        self.deadline = deadline
        status = PendingTask()
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
    
    func getTask(id: Int) -> Task {
        return tasks[id]
    }
    
    func addTask(task: Task) {
        task.id = taskCount
        tasks[task.id] = task
        list.append(task)
        taskCount = taskCount + 1
    }
    
    func fillDefault() {
        var t1 = Task("Pasear al perro", "Sacar al perro a pasear antes de desayunar.", Task.MEDIUM_PRIORITY,
 false, nil)
        var t2 = Task("Estudiar para examen", "Estudiar para el esxamen de historia de la semana que viene.", Task.HIGH_PRIORITY, true, Date(timeIntervalSinceNow: 600000))
        var t3 Task("Regalo Ana", "Comprar el regalo de cumpleaños para Ana.", Task.MEDIUM_PRIORITY, false, Date(timeIntervalSinceNow: 900000)
        var t4 = Task("Star wars", "Ir a ver Star Wars al cine", Task.LOW_PRIORITY), false, nil)
        addTask(t1)
        addTask(t2)
        addTask(t3)
        addTask(t4)
    }
    
}
