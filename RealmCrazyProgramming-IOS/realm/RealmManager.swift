//
//  RealmManager.swift
//  RealmCrazyProgramming-IOS
//
//  Created by Mahmudul on 30/12/21.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?
    @Published private(set) var tasks: [TaskModel] = []
    
    init() {
        openRealm()
        getTasks()
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            
            localRealm = try? Realm()
        } catch {
            print("Error opening Realm: \(error)")
        }
    }
    
    func addTask(taskTitle: String) {
        if let localRealm = localRealm {
            do {
                try localRealm.write() {
                    let newTask = TaskModel(value: ["title": taskTitle, "isComplete": false])
                    localRealm.add(newTask)
                    getTasks()
                    print("Added new task to Realm: \(newTask)")
                }
                
            } catch {
                print("Error adding task to Realm: \(error)")
            }
        }
    }
    
    func getTasks() {
        if let localRealm = localRealm {
            let taskLists = localRealm.objects(TaskModel.self).sorted(byKeyPath: "isComplete")
            tasks = []
            
            taskLists.forEach() { task in
                tasks.append(task)
            }
        }
    }
    
    func updateTask(id: ObjectId, isComplete: Bool) {
        if let localRealm = localRealm {
            do {
                let updateTask = localRealm.objects(TaskModel.self).filter(NSPredicate(format: "id == %@", id))
                guard !updateTask.isEmpty else { return }
                
                try localRealm.write {
                    updateTask[0].isComplete = isComplete
                    getTasks()
                    print("Updated task with id: \(id)! completed status: \(isComplete)")
                }
            } catch {
                print("Error updating task \(id) to Realm : \(error)")
            }
        }
    }
    
    func updateTaskValue(id: ObjectId, title: String) {
        if let localRealm = localRealm {
            do {
                let updateTask = localRealm.objects(TaskModel.self).filter(NSPredicate(format: "id == %@", id))
                guard !updateTask.isEmpty else { return }
                
                try localRealm.write {
                    updateTask[0].title = title
                    getTasks()
                    print("Updated value with id: \(id)! completed status: \(title)")
                }
            } catch {
                print("Error updating task \(id) to Realm : \(error)")
            }
        }
    }
    
    func deleteTask(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                let deleteTask = localRealm.objects(TaskModel.self).filter(NSPredicate(format: "id == %@", id))
                guard !deleteTask.isEmpty else { return }
                
                try localRealm.write {
                    localRealm.delete(deleteTask)
                    getTasks()
                    print("Deleted task with id: \(id)")
                }
            } catch {
                print("Error deleting task \(id) from Realm: \(error)")
            }
        }
    }
}
