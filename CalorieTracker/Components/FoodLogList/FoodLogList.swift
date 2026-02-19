//
//  FoodLogList.swift
//  CalorieTracker
//
//  Created by Cache Salyers on 2/19/26.
//

import SwiftUI
import SwiftData

struct FoodLogList: View {
    @Query private var foodLogs: [FoodLogItem]
    
    var body: some View {
        Section {
            Text("Food Log")
            
            List {
                ForEach(foodLogs) { log in
                    
                    Text(log.name)
                }
            }
            .listStyle(PlainListStyle())
        }
        .padding(10)
        .cardModifier()
    }
}

#Preview {
    FoodLogList()
}
