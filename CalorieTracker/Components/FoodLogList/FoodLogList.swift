//
//  FoodLogList.swift
//  CalorieTracker
//
//  Created by Cache Salyers on 2/19/26.
//

import SwiftUI
import SwiftData

struct FoodLogList: View {
    @Binding var foodLogs: [FoodLogItem]
    
    private var todaysFoodLogs: [FoodLogItem] {
        let today = Date()
        let calendar = Calendar.current
        
        return foodLogs.filter { log in
            calendar.isDate(log.creationDate, inSameDayAs: today)
        }
    }
    var body: some View {
        Section {
            Text("Food Log")
            
            List {
                ForEach(todaysFoodLogs) { log in
                    FoodLogItemView(foodLog: log)
                }
            }
            .listStyle(PlainListStyle())
        }
        .padding(10)
        .cardModifier()
    }
}
