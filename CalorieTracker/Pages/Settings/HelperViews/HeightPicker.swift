//
//  HeightPicker.swift
//  CalorieTracker
//
//  Created by Cache Salyers on 2/20/26.
//

import SwiftUI

struct HeightPicker: View {
    @State private var viewModel = HealthDataViewModel()

    @State private var selectedFt: Int = 1
    @State private var selectedInch: Int = 1
    
    @Binding var selectedHeightInCm: Int

    @State private var totalInches: Int = 0
    
    var body: some View {
        HStack {
            Text("Height")
                .padding(10)
            
            Picker("Height", selection: $selectedFt) {
                ForEach(1...15, id: \.self) { value in
                    Text(String(value)).tag(value)
                }
            }.pickerStyle(.wheel)
                .frame(height: 100)
                .clipped()
            Text("ft")
            
            Picker("Height", selection: $selectedInch) {
                ForEach(1...15, id: \.self) { value in
                    Text(String(value)).tag(value)
                }
            }.pickerStyle(.wheel)
                .frame(height: 100)
                .clipped()
            Text("in")
                .padding(.trailing, 20)
        }
        .onChange(of: selectedFt) {
            updateToCm()
        }
        .onChange(of: selectedInch) {
            updateToCm()
        }
        .onChange(of: viewModel.height) {
            totalInches = viewModel.height
            
            convertInchToCm()
        }
    }
    
    private func updateToCm() {
        // 1. Calculate total inches
        let totalInches = Double((selectedFt * 12) + selectedInch)
        
        // 2. Convert to CM (1 inch = 2.54 cm)
        selectedHeightInCm = Int(totalInches * 2.54)
    }
    
    private func convertInchToCm() {
        let ft = totalInches / 12
        let remainingInches = totalInches.remainderReportingOverflow(dividingBy: 12).partialValue
        
        selectedFt = ft
        selectedInch = remainingInches
        selectedHeightInCm = Int(Double(totalInches) * 2.54)
    }
}
