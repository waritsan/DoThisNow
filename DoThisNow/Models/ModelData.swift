//
//  ModelData.swift
//  DoThisNow
//
//  Created by Warit Santaputra on 17/2/21.
//

import Foundation

final class ModelData: ObservableObject {
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }
    
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("tasks.data")
    }
    
    @Published var tasks: [Task] = []
    
    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                #if DEBUG
                DispatchQueue.main.async {
                    self?.tasks = Task.data
                }
                #endif
                return
            }
            guard let savedTasks = try? JSONDecoder().decode([Task].self, from: data) else {
                fatalError("Can't decode saved task data")
            }
            DispatchQueue.main.async {
                self?.tasks = savedTasks
            }
        }
    }
    
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let tasks = self?.tasks else { fatalError("Self out of scope") }
            guard let data = try? JSONEncoder().encode(tasks) else { fatalError("Error encoding data") }
            do {
                let outfile = Self.fileURL
                try data.write(to: outfile)
            } catch {
                fatalError("Can't write to file")
            }
        }
    }
}
