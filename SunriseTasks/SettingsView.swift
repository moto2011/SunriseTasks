//
//  SettingsView.swift
//  SunriseTasks
//
//  Created by nakamura on 2025/10/18.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("アプリ設定") {
                    Text("通知設定")
                    Text("テーマ設定")
                }
            }
            .navigationTitle("設定")
        }
    }
}

#Preview {
    SettingsView()
}
