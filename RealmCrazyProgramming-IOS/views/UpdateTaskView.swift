//
//  UpdateTaskView.swift
//  RealmCrazyProgramming-IOS
//
//  Created by Mahmudul on 2/1/22.
//

import SwiftUI
import RealmSwift

struct UpdateTaskView: View {
    @Binding var task: String
    @Binding var id: ObjectId
    @Binding var completed: Bool
    @EnvironmentObject var realmManager: RealmManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TextField(
                "Enter your task here",
                text: $task
            )
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            
            Button(action: {
                realmManager.updateTaskValue(id: id, title: task)
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Update")
                    .bold()
                    .padding(EdgeInsets.init(top: 8, leading: 32, bottom: 8, trailing: 32))
                    .background(Color.green)
                    .foregroundColor(.white)
            })
        }
    }
}

struct UpdateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateTaskView(task: .constant("Criconfo"), id: .constant(ObjectId()), completed: .constant(false))
            .environmentObject(RealmManager())
    }
}
