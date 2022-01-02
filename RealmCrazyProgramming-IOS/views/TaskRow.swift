//
//  TaskRow.swift
//  RealmCrazyProgramming-IOS
//
//  Created by Mahmudul on 30/12/21.
//

import SwiftUI
import RealmSwift

struct TaskRow: View {
    @State var id: ObjectId
    @State var task: String
    @State var completed: Bool
    @State var showAlert: Bool = false
    @State var updateStatus: Bool = false
    @EnvironmentObject var realmManager: RealmManager
    
    var body: some View {
        ZStack {
            HStack(spacing: 20) {
                Image(systemName: completed ? "checkmark.circle" : "circle")
                    .onTapGesture {
                        realmManager.updateTask(id: id, isComplete: !completed)
                    }
                
                Text(task)
                
                Spacer()
                
                Image(systemName: "pencil.circle")
                    .foregroundColor(.green)
                    .onTapGesture {
                        withAnimation() {
                            self.updateStatus.toggle()
                        }
                    }
                
//                Button(action: {
//                    withAnimation { self.updateStatus.toggle() }
//                }, label : {
//                    Image(systemName: "pencil.circle")
//                        .resizable()
//                        .frame(width: 24, height: 24)
//                        .foregroundColor(.blue)
//                })
                
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .onTapGesture {
                        self.showAlert = true
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Realm Database"), message: Text("Are you sure to delete data?"), primaryButton: .destructive(Text("Yes")) {
                            realmManager.deleteTask(id: id)
                        }, secondaryButton: .cancel(Text("No")))
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
        .sheet(isPresented: $updateStatus) {
            UpdateTaskView(task: $task, id: $id, completed: $completed)
        }
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(id: ObjectId(), task: "Do laundry", completed: true)
            .environmentObject(RealmManager())
    }
}
