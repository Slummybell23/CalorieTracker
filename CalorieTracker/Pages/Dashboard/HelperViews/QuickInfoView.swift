//
//  QuickInfoView.swift
//  CalorieTracker
//
//  Created by Cache Salyers on 2/17/26.
//

import SwiftUI
import SwiftData
import HealthKit


struct QuickInfoView: View {
    @Binding var dailyLog: DailyLog
    
    @State private var viewModel = HealthDataViewModel()

    var totalCalories: Int {
        var sum = 0
        for log in dailyLog.foodLog {
            sum += log.calories
        }
        return sum
    }
    
    var caloriesBurned: Int {
        return Int(viewModel.allActiveEnergy)
    }
    
    var bmr: Int {
        return dailyLog.userBiometrics.bmr
    }
    
    //Expenditure is BMR + apple health calorie count
    var expenditure: Int {
        return bmr + caloriesBurned
    }
    
    
    //Total available calories is BMR+AppleHealth-Deficit - consumed
    var available: Int {
        return expenditure-500-totalCalories
    }
    
    
    var body: some View {
        Section {
            HStack {
                VStack{
                    Text("\(totalCalories)")
                    Text("Consumed")
                }
                .padding(10)
                VStack{
                    Text("\(expenditure)")
                    Text("Expenditure")
                }
                .padding(10)
                VStack{
                    Text("\(available)")
                    Text("Remaining")
                }
                .padding(10)
            }
        }
        .cardModifier()
    }
}

