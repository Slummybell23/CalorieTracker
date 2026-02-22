//
//  BodyInformationView.swift
//  CalorieTracker
//
//  Created by Cache Salyers on 2/20/26.
//

import SwiftUI

struct BodyInformationView: View {
    @Binding var weight: Double
    @Binding var sex: String
    let genderOptions = ["Male", "Female", "Other", "Prefer not to say"]
    @Binding var height: Int
    @Binding var age: Int
    
    @State private var dateOfBirth: Date = {
        var components = DateComponents()
        components.year = 1990
        components.month = 1
        components.day = 1
        return Calendar.current.date(from: components) ?? Date()
    }()
    
    @State private var viewModel = HealthDataViewModel()
    
    private func yearsOld(from dob: Date) -> Int {
        let now = Date()
        let components = Calendar.current.dateComponents([.year], from: dob, to: now)
        return components.year ?? 0
    }
    
    var body: some View {
        Section(header: Text("Body Information")) {
            HStack {
                Text("Weight")
                TextField("Enter Weight", value: $weight, format: .number)
                    .keyboardType(.numberPad)
                    .onChange(of: weight) {
                        if weight < 0 { weight = 0 }
                        if weight > 9000 { weight = 9000 }
                    }
            }
            
            Picker("Sex (Used for BMR Calculation)", selection: $sex) {
                ForEach(genderOptions, id: \.self) { gender in
                    Text(gender).tag(gender)
                }
            }
            .pickerStyle(.menu)
            
            VStack(alignment: .leading, spacing: 8) {
                DatePicker("Date of Birth", selection: $dateOfBirth, in: ...Date(), displayedComponents: .date)
                Text("Age: \(yearsOld(from: dateOfBirth)) years")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            HeightPicker(selectedHeightInCm: $height)
        }
        .onChange(of: viewModel.bodyMass) {
            weight = viewModel.bodyMass
        }
        .onChange(of: dateOfBirth) {
            age = yearsOld(from: dateOfBirth)
        }
        .onAppear {
            age = yearsOld(from: dateOfBirth)
        }
    }
}

