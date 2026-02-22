//
//  SettingsView.swift
//  CalorieTracker
//
//  Created by Cache Salyers on 2/20/26.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var userBiometrics: [UserBiometrics]

    @State var weight: Double = 0.0
    @State var heightInCm: Int = 0
    @State var sex: String = "Male"
    @State var age: Int = 0
    
    private var bmr: Int {
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

    var body: some View {
        VStack {
            Text("Settings")
            Form {
                BodyInformationView(weight: $weight, sex: $sex, height: $heightInCm, age: $age)
                
                Section("Basal Metabolic Rate") {
                    Text("\(bmr)")
                }
                
                Button("Save Changes") {
                    updateUserBiometrics()
                }
                .buttonStyle(.glassProminent)
            }
        }
        .onChange(of: heightInCm) {
            print("Height changed \(heightInCm)")
            print("New BMR \(bmr)")
        }
        .onChange(of: weight) {
            print("Weight changed \(weight)")
            print("New BMR \(bmr)")
        }
        .onChange(of: sex) {
            print("New BMR \(bmr)")
        }
        .onChange(of: age) {
            print("New BMR \(bmr)")
            print("Age Changed")
        }
    }
    
    private func updateUserBiometrics() {
        if let existing = userBiometrics.first {
            modelContext.delete(existing)
            do {
                try modelContext.save()
                print("Deleted existing UserBiometrics and saved context successfully.")
            } catch {
                print("Error saving context after deleting existing UserBiometrics: \(error)")
            }
        }

        let newUserBiometrics = UserBiometrics(weight: weight, heightInCm: heightInCm, sex: sex, age: age)
        modelContext.insert(newUserBiometrics)
        do {
            try modelContext.save()
            print("Inserted new UserBiometrics and saved context successfully.")
        } catch {
            print("Error saving context after inserting new UserBiometrics: \(error)")
        }
    }
}

#Preview {
    SettingsView()
}
