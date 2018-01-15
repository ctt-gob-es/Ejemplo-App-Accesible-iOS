//
//  taskListDelegate.swift
//  ToDoManager
//
//  Created by DCC on 11/1/18.
//  Copyright © 2018 DCC. All rights reserved.
//

import Foundation

protocol TaskListDelegate {
    func updateTask(task: Task, position pos: IndexPath)
    func insertTask(task: Task)
    func reloadTasks()
}
