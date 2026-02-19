//
//  DashboardView.swift
//  CalorieTracker
//
//  Created by Cache Salyers on 2/17/26.
//

import Foundation
import SwiftUI

struct DashboardView: View {
    @State var showLogFoodView: Bool = false
    var body: some View {
        VStack {

            QuickInfoView()
            
            FoodLogList()
            
            Spacer()
            
            HStack {
                Button(action: {
                    showLogFoodView.toggle()
                }, label: {
                    Label("Log Food", systemImage: "plus")
                })
                .buttonStyle(.glassProminent)
                
            }
        }
        .sheet(isPresented: $showLogFoodView, content: {
            LogFoodView(showFoodLogView: $showLogFoodView)
        })
        
    }
}

#Preview {
    DashboardView()
}
