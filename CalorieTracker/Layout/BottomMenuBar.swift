//
//  BottomMenuBar.swift
//  CalorieTracker
//
//  Created by Cache Salyers on 2/17/26.
//

import SwiftUI

struct BottomMenuBar: View {
    @State var tabSelection: Int = 1
    
    var body: some View {
        ZStack {
            if(tabSelection == 1) {
                DashboardView()
            }
            else if(tabSelection == 2) {
                SettingsView()
            }
            else {
                Text("Tab \(tabSelection)")
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    Menu(/*@START_MENU_TOKEN@*/"Menu"/*@END_MENU_TOKEN@*/) {
                        Button("Show Dashboard") {
                            tabSelection = 1
                        }
                        Button("Show Settings") {
                            tabSelection = 2
                        }
                    }
                    .padding(10)
                }
            }
        }
    }
}

#Preview {
    BottomMenuBar()
}
