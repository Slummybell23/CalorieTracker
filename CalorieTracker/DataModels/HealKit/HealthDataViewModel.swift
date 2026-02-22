//
//  HealthKitViewModel.swift
//  CalorieTracker
//
//  Created by Cache Salyers on 2/19/26.
//

import Foundation
import HealthKit
import Observation

@MainActor
@Observable class HealthDataViewModel {
    
    // 1.
    var stepCount: Double = 0
    var heartRate: Double = 0
    var activeEnergy: Double = 0
    var allActiveEnergy: Double = 0
    var isAuthorized: Bool = false
    var bodyMass: Double = 0
    var height: Int = 0
    var dateOfBirth: Date?
    
    var errorMessage: String?

    init() {
        Task { await requestAuthorization() }
    }

    // 2.
    func requestAuthorization() async {
        do {
            let success = try await HealthKitManager.shared.requestAuthorization()
                self.isAuthorized = success
            if success {
                await fetchAllHealthData()
            }
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }

    // 3.
    func fetchAllHealthData() async {
        async let steps: () = fetchStepCount()
        async let rate: ()  = fetchHeartRate()
        async let energy: () = fetchActiveEnergy()
        async let totalEnergy: () = fetchAllActiveEnergy()
        async let bodyMass: () = fetchBodyMass()
        async let height: () = fetchHeight()
        async let dob: () = fetchDob()
        _ = await (steps, rate, energy, totalEnergy, bodyMass, height, dob)
    }

    // 4.
    func fetchStepCount() async {
        if let sample = try? await HealthKitManager.shared.fetchMostRecentSample(for: .stepCount) {
            let value = sample.quantity.doubleValue(for: HKUnit.count())
            self.stepCount = value
        }
    }

    func fetchHeartRate() async {
        if let sample = try? await HealthKitManager.shared.fetchMostRecentSample(for: .heartRate) {
            let value = sample.quantity
                .doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
            self.heartRate = value
        }
    }

    func fetchActiveEnergy() async {
        if let sample = try? await HealthKitManager.shared.fetchMostRecentSample(for: .activeEnergyBurned) {
            let value = sample.quantity.doubleValue(for: HKUnit.kilocalorie())
            self.activeEnergy = value
        }
    }
    
    func fetchAllActiveEnergy() async {
        if let data = try? await HealthKitManager.shared.fetchDailySum(for: .activeEnergyBurned, unit: HKUnit.kilocalorie()) {
            self.allActiveEnergy = data
        }
    }
    
    func fetchBodyMass() async {
        if let data = try? await HealthKitManager.shared.fetchMostRecentHealthData(for: .bodyMass, unit: HKUnit.pound()) {
            self.bodyMass = Double(data)
        }
    }
    
    func fetchHeight() async {
        if let data = try? await HealthKitManager.shared.fetchMostRecentHealthData(for: .height, unit: HKUnit.inch()) {
            self.height = Int(data)
        }
    }
    
    func fetchDob() async {
        if let data = try? HealthKitManager.shared.fetchDateOfBirth() {
            self.dateOfBirth = data
        }
    }
}
