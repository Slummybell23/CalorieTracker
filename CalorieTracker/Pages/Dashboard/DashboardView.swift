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
                        Text("0/100")
                        Text("Consumed")
                    }
                    Spacer()
                }
            }
            
            Spacer()
        }
        
    }
}

#Preview {
    DashboardView()
}
