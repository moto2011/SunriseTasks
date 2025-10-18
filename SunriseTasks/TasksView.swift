//
//  TasksView.swift
//  SunriseTasks
//
//  Created by nakamura on 2025/10/18.
//

import SwiftUI

struct TasksView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("タスク一覧")
            }
            .navigationTitle("タスク")
        }
    }
}

#Preview {
    TasksView()
}
