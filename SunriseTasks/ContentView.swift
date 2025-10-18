//
//  ContentView.swift
//  SunriseTasks
//
//  Created by nakamura on 2025/10/15.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TasksView()
                .tabItem {
                    Label("タスク", systemImage: "checklist")
                }

            SettingsView()
                .tabItem {
                    Label("設定", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    ContentView()
}
