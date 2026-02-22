//
//  DailyLog.swift
//  CalorieTracker
//
//  Created by Cache Salyers on 2/21/26.
//

import SwiftData
import Foundation

@Model
final class DailyLog {
    var id: UUID = UUID()
    var creationDate: Date
    var foodLog: [FoodLogItem]
    var userBiometrics: UserBiometrics
    
    init(creationDate: Date, foodLog: [FoodLogItem], userBiometrics: UserBiometrics) {
        self.creationDate = creationDate
        self.foodLog = foodLog
        self.userBiometrics = userBiometrics
    }
}
