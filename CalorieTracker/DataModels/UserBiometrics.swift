//
//  UserBiometrics.swift
//  CalorieTracker
//
//  Created by Cache Salyers on 2/21/26.
//

import SwiftData
import Foundation

@Model
final class UserBiometrics {
    var id: UUID = UUID()
    var weight: Double = 0.0
    var heightInCm: Int = 0
    var sex: String = "Male"
    var age: Int = 0
    
    var bmr: Int {
        let age = age
        let weightInKg = weight * 0.45359237
        if sex == "Male" {
            let bmrValue = 88.362 + (13.397 * weightInKg) + (4.799 * Double(heightInCm)) - (5.677 * Double(age))
            return Int(bmrValue)
        } else if sex == "Female" {
            let bmrValue = 447.593 + (9.247 * weightInKg) + (3.098 * Double(heightInCm)) - (4.330 * Double(age))
            return Int(bmrValue)
        } else {
            return 0
        }
    }

    init(weight: Double, heightInCm: Int, sex: String, age: Int) {
        self.weight = weight
        self.heightInCm = heightInCm
        self.sex = sex
        self.age = age
    }
}
