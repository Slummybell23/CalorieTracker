//
//  FoodLogItem.swift
//  CalorieTracker
//
//  Created by Cache Salyers on 2/19/26.
//

import SwiftUI
import SwiftData

struct FoodLogItemView: View {
    var foodLog: FoodLogItem
    
    var body: some View {
        HStack {
            Text("Eaten: \(foodLog.creationDate, style: .time)")
                .padding(10)
            Spacer()
            Text(foodLog.name)
            
            Spacer()
            
            Text("\(foodLog.calories) kcal")
                .padding(10)
        }
    }
}

#Preview {
    FoodLogItemView(foodLog: FoodLogItem(name: "Bagel", creationDate: Date(), calories: 200))
}
