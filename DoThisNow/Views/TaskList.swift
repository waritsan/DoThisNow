//
//  TaskList.swift
//  DoThisNow
//
//  Created by Warit Santaputra on 16/2/21.
//

import SwiftUI

struct TaskList: View {
    @Binding var tasks: [Task]
    @Environment(\.scenePhase) private var scenePhase
    @State var isPresented = false
    @State private var newTask = Task(name: "")
    let saveAction: () -> Void
    
    var body: some View {
        List {
            Button(action: {
                var tempTasks = tasks
                let firstTask = tempTasks.removeFirst()
                tempTasks.append(firstTask)
                tasks = tempTasks
                print(tasks)
            }, label: {
                Text("Start")
            })
            ForEach(tasks) { task in
                Text(task.name)
            }
        }
        .navigationTitle("Tasks")
        .navigationBarItems(trailing: Button(action: {
            isPresented = true
        }, label: {
            Image(systemName: "plus")
        }))
        .sheet(isPresented: $isPresented, content: {
            NavigationView {
                EditTask(task: $newTask)
                    .navigationBarItems(leading: Button("Dismiss") {
                        isPresented = false
                    }, trailing: Button("Add") {
                        tasks.append(newTask)
                        isPresented = false
                    })
            }
        })
        .onChange(of: scenePhase) { (phase) in
            if phase == .inactive { saveAction() }
        }
    }
}

struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskList(tasks: .constant(Task.data), saveAction: {})
    }
}
