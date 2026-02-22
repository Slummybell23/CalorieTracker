//
//  LogFoodView.swift
//  CalorieTracker
//
//  Created by Cache Salyers on 2/19/26.
//

import SwiftUI
import SwiftData

struct LogFoodView: View {
    @Binding var dailyLog: DailyLog

    @State private var foodName: String = ""
    @State private var eatenDate: Date = Date()
    @State private var calories: Int = 0
    
    @Binding var showFoodLogView: Bool

    var body: some View {
        Form {
            Section {
                Label("Enter Food Name", systemImage: "pencil")
                TextField("Food Name", text: $foodName)
            }
            
            Section {
                
                DatePicker("Time Eaten", selection: $eatenDate, displayedComponents: .hourAndMinute)
            }
            
            Section {
                Label("Enter Food Calroies", systemImage: "carrot")
                TextField("Enter food calories", value: $calories, format: .number)
                    .keyboardType(.numberPad)
            }
            
            Section {
                Button("Log Food") {
                    dailyLog.foodLog.append(FoodLogItem(name: foodName, creationDate: eatenDate, calories: calories))

                    showFoodLogView = false
                }
            }
        }
    }
}
