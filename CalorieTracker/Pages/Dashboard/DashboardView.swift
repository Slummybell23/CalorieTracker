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
            Section {
                HStack {
                    VStack{
                        Text("100")
                        Text("Consumed")
                    }
                    .padding(10)
                    VStack{
                        Text("100")
                        Text("Expenditure")
                    }
                    .padding(10)
                    VStack{
                        Text("100")
                        Text("Remaining")
                    }
                    .padding(10)
                }
            }
            .cardModifier()
            
            Spacer()
        }
        
    }
}

#Preview {
    DashboardView()
}
