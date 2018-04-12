//
//  EditTaskDelegate.swift
//  ToDoManager
//
//  Created by DCC on 17/1/18.
//  Copyright © 2018 DCC. All rights reserved.
//

import Foundation

protocol EditTask {
    var task: Task? { get set }
    var pos: IndexPath? { get set }
    func saveTask()
}
