//
//  FoodLogItem.swift
//  CalorieTracker
//
//  Created by Cache Salyers on 2/19/26.
//

import SwiftData
import Foundation

@Model
final class FoodLogItem {
    var id: UUID = UUID()
    var name: String
    var creationDate: Date
    var calories: Int

    init(name: String, creationDate: Date, calories: Int) {
        self.name = name
        self.calories = calories
        self.creationDate = creationDate
    }
}
