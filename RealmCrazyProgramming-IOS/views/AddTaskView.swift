//
//  AddTaskView.swift
//  RealmCrazyProgramming-IOS
//
//  Created by Mahmudul on 30/12/21.
//

import SwiftUI

struct AddTaskView: View {
    @State private var title: String = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var realmManager: RealmManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Create a new task")
                .font(.title2).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField (
                "Enter your task here",
                text: $title
            )
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button {
                if title != "" {
                    realmManager.addTask(taskTitle: title)
                }
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Add task")
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(Color(hue: 0.328, saturation: 0.796, brightness: 0.408))
                    .cornerRadius(30)
            }
            
            Spacer()
        }
        .padding(.top, 40)
        .padding(.horizontal)
        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
        //.ignoresSafeArea()
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
            .environmentObject(RealmManager())
    }
}
