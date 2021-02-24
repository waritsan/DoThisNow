//
//  Task.swift
//  DoThisNow
//
//  Created by Warit Santaputra on 17/2/21.
//

import Foundation

struct Task: Identifiable, Codable {
    var id: UUID
    var name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}

extension Task {
    static var data: [Task] {
        [
            Task(name: "Practice piano"),
            Task(name: "Read a book"),
            Task(name: "Work on the app"),
            Task(name: "Study Japanese")
        ]
    }
}
