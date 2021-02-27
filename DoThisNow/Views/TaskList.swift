//
//  TaskList.swift
//  DoThisNow
//
//  Created by Warit Santaputra on 16/2/21.
//

import SwiftUI

struct TaskList: View {
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresented = false
    @State private var newTask = Task(name: "")
    @State private var editMode = EditMode.inactive
    @Binding var tasks: [Task]
    let saveAction: () -> Void
    private var addButton: some View {
        switch editMode {
        case .inactive:
            return AnyView(Button(action: { isPresented = true }, label: {
                Image(systemName: "plus")
            }))
        default:
            return AnyView(EmptyView())
        }
    }
    
    var body: some View {
        List {
            Button(action: start, label: {
                Text("Start")
            })
            ForEach(tasks) { task in
                Text(task.name)
            }
            .onDelete(perform: { indexSet in
                tasks.remove(atOffsets: indexSet)
            })
            .onMove(perform: { indices, newOffset in
                tasks.move(fromOffsets: indices, toOffset: newOffset)
            })
        }
        .navigationTitle("Tasks")
        .navigationBarItems(leading: EditButton(), trailing: addButton)
        .environment(\.editMode, $editMode)
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
    
    private func start() {
        var tempTasks = tasks
        let firstTask = tempTasks.removeFirst()
        tempTasks.append(firstTask)
        tasks = tempTasks
    }
}

struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskList(tasks: .constant(Task.data), saveAction: {})
    }
}
