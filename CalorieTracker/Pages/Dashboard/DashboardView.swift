//
//  DashboardView.swift
//  CalorieTracker
//
//  Created by Cache Salyers on 2/17/26.
//

import Foundation
import SwiftUI
import SwiftData

struct DashboardView: View {
    @Environment(\.modelContext) private var modelContext

    @Query private var dailyLogs: [DailyLog]
    @Query private var userBiometrics: [UserBiometrics]
    
    @State var dateToView: Date = Date()
    @State var showLogFoodView: Bool = false
    
    private var logForDateCompute: DailyLog? {
        if let existing = dailyLogs.first(where: {
            Calendar.current.isDate($0.creationDate, inSameDayAs: dateToView)
        }) {
            return existing
        }

        print("There are \(dailyLogs.count) daily logs")
        
        guard let biometrics = userBiometrics.first else {
            return nil
        }

        let newLog = DailyLog(creationDate: dateToView, foodLog: [], userBiometrics: biometrics)
        modelContext.insert(newLog)
        try? modelContext.save()
        
        print("There are now \(dailyLogs.count) daily logs")

        return newLog
    }
    
    @State var logForDate: DailyLog?
    
    var body: some View {
        VStack {
            if let logBinding = Binding($logForDate) {
                
                QuickInfoView(dailyLog: Binding(
                    get: { logBinding.wrappedValue },
                    set: { logBinding.wrappedValue = $0 }
                ))

                let foodLogBinding = Binding(get: {
                    logBinding.wrappedValue.foodLog
                }, set: { newValue in
                    logBinding.wrappedValue.foodLog = newValue
                })

                FoodLogList(foodLogs: foodLogBinding)
            } else {
                Text("No log available for this date.")
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    logForDate = logForDate ?? logForDateCompute
                    showLogFoodView.toggle()
                }, label: {
                    Label("Log Food", systemImage: "plus")
                })
                .buttonStyle(.glassProminent)
                
            }
        }
        .sheet(isPresented: $showLogFoodView, content: {
            if let _ = logForDate {
                let nonOptionalBinding = Binding<DailyLog>(
                    get: { logForDate! },
                    set: { logForDate = $0 }
                )
                LogFoodView(dailyLog: nonOptionalBinding, showFoodLogView: $showLogFoodView)
            } else {
                Text("No log available for this date.")
                    .foregroundStyle(.secondary)
            }
        })
        .onAppear {
            logForDate = logForDateCompute
            
        }
        
    }
}

#Preview {
    DashboardView()
}
