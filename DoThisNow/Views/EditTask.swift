//
//  EditTask.swift
//  DoThisNow
//
//  Created by Warit Santaputra on 17/2/21.
//

import SwiftUI

struct EditTask: View {
    @Binding var task: Task
    
    var body: some View {
        List {
            Section(header: Text("Task Name")) {
                TextField("Name", text: $task.name)
            }
        }
    }
}

struct EditTask_Previews: PreviewProvider {
    static var previews: some View {
        EditTask(task: .constant(Task.data[0]))
    }
}
