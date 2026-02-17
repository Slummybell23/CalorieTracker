//
//  DashboardView.swift
//  CalorieTracker
//
//  Created by Cache Salyers on 2/17/26.
//

import Foundation
import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack {

            QuickInfoView()
            
            Section {
                Text("Food Log")
                
                List {
                    Text("Test log item")
                }
                .listStyle(PlainListStyle())
            }
            .padding(10)
            .cardModifier()
            
            Spacer()
            
            HStack {
                Button(action: {
                    
                }, label: {
                    Label("Log Food", systemImage: "plus")
                })
                .buttonStyle(.glassProminent)
                
            }
        }
        
    }
}

#Preview {
    DashboardView()
}
