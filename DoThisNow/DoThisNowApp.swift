//
//  DoThisNowApp.swift
//  DoThisNow
//
//  Created by Warit Santaputra on 16/2/21.
//

import SwiftUI

@main
struct DoThisNowApp: App {
    @ObservedObject private var data = ModelData()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TaskList(tasks: $data.tasks) {
                    data.save()
                }
            }
            .onAppear {
                data.load()
            }
        }
    }
}
