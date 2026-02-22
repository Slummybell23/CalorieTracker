//
//  CalorieTrackerApp.swift
//  CalorieTracker
//
//  Created by Cache Salyers on 2/15/26.
//

import SwiftUI
import SwiftData

@main
struct CalorieTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [FoodLogItem.self, UserBiometrics.self, DailyLog.self])
    }
}
