//
//  HealthKitManager.swift
//  CalorieTracker
//
//  Created by Cache Salyers on 2/19/26.
//

import Foundation
import HealthKit

@MainActor
class HealthKitManager {

    // 1.
    static let shared = HealthKitManager()
    private let healthStore = HKHealthStore()

    private init() {}

    // 2.
    func requestAuthorization() async throws -> Bool {
        // Ensure HealthKit is available on this device
        guard HKHealthStore.isHealthDataAvailable() else { return false }

        // Define the types we want to read
        let readTypes: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKObjectType.quantityType(forIdentifier: .bodyMass)!,
            HKObjectType.quantityType(forIdentifier: .height)!
        ]

        return try await withCheckedThrowingContinuation { continuation in
            healthStore.requestAuthorization(toShare: [], read: readTypes) { success, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: success)
                }
            }
        }
    }

    // 3.
    func fetchMostRecentSample(for identifier: HKQuantityTypeIdentifier) async throws -> HKQuantitySample? {
        // Get the quantity type for the identifier
        guard let quantityType = HKObjectType.quantityType(forIdentifier: identifier) else {
            return nil
        }

        // Query for samples from start of today until now, sorted by end date descending
        let predicate = HKQuery.predicateForSamples(
            withStart: Calendar.current.startOfDay(for: Date()),
            end: Date(),
            options: .strictStartDate
        )
        let sortDescriptor = NSSortDescriptor(
            key: HKSampleSortIdentifierEndDate,
            ascending: false
        )

        return try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(
                sampleType: quantityType,
                predicate: predicate,
                limit: 1,
                sortDescriptors: [sortDescriptor]
            ) { _, samples, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: samples?.first as? HKQuantitySample)
                }
            }
            healthStore.execute(query)
        }
    }
    
    func fetchDailySum(for identifier: HKQuantityTypeIdentifier, unit: HKUnit) async throws -> Double {
        // 1. Get the quantity type for the identifier
        guard let quantityType = HKObjectType.quantityType(forIdentifier: identifier) else {
            // Throw an error if the identifier is invalid
            throw NSError(domain: "HealthKitManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid Quantity Type"])
        }

        // 2. Query for samples from start of today until now
        let predicate = HKQuery.predicateForSamples(
            withStart: Calendar.current.startOfDay(for: Date()),
            end: Date(),
            options: .strictStartDate
        )

        // 3. Use HKStatisticsQuery with the .cumulativeSum option
        return try await withCheckedThrowingContinuation { continuation in
            let query = HKStatisticsQuery(
                quantityType: quantityType,
                quantitySamplePredicate: predicate,
                options: .cumulativeSum
            ) { _, result, error in
                
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let sumQuantity = result?.sumQuantity() {
                    // 4. Extract the sum as a Double using the provided unit
                    let total = sumQuantity.doubleValue(for: unit)
                    continuation.resume(returning: total)
                } else {
                    // If there is no error but also no data, it means 0 for the day
                    continuation.resume(returning: 0.0)
                }
            }
            
            healthStore.execute(query)
        }
    }
    
    func fetchMostRecentHealthData(for identifier: HKQuantityTypeIdentifier, unit: HKUnit) async throws -> Double {
        guard let quantityType = HKObjectType.quantityType(forIdentifier: identifier) else {
            throw NSError(domain: "HealthKitManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid Quantity Type"])
        }

        // Passing nil as the predicate tells HealthKit to ignore time constraints
        // and look at the entire history for this data type.
        return try await withCheckedThrowingContinuation { continuation in
            let query = HKStatisticsQuery(
                quantityType: quantityType,
                quantitySamplePredicate: nil,
                options: .mostRecent
            ) { _, result, error in
                
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }

                // mostRecentQuantity() grabs the single latest data point found
                if let mostRecent = result?.mostRecentQuantity() {
                    let value = mostRecent.doubleValue(for: unit)
                    continuation.resume(returning: value)
                } else {
                    // Returns 0.0 only if the user has NEVER logged this data type
                    continuation.resume(returning: 0.0)
                }
            }
            
            healthStore.execute(query)
        }
    }
    
    func fetchDateOfBirth() throws -> Date? {
        // 1. Date of Birth is a characteristic, not a quantity sample.
        // We access it directly from the healthStore.
        let dateComponents = try healthStore.dateOfBirthComponents()
        
        // 2. Convert HKDateComponents into a standard Swift Date
        return Calendar.current.date(from: dateComponents)
    }
}
