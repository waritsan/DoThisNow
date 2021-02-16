//
//  TaskList.swift
//  DoThisNow
//
//  Created by Warit Santaputra on 16/2/21.
//

import SwiftUI

struct TaskList: View {
    let tasks = ["Read a book", "Learn Japanese", "Practice piano"]
    let time = 15
    
    var body: some View {
        List {
            ForEach(tasks, id: \.self, content: { task in
                Text(task)
            })
        }
    }
}

struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskList()
    }
}
