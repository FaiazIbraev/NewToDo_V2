//
//  Task.swift
//  ToDoApp_v2
//
//  Created by Faiaz Ibraev on 25/8/22.
//

import Foundation

struct Task : Codable{
    var title : String
    var isDone : Bool
    
    func changeIsDoneProperty() -> Task{
    let task = Task(title: title, isDone:!isDone)
        
        return task
    }
}
