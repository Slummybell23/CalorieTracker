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
        VStack {
            
            if(tabSelection == 1) {
                DashboardView()
            }
            else {
                Text("Tab \(tabSelection)")
            }
            
            Spacer()
            
            HStack {
                Spacer()
                
                Menu(/*@START_MENU_TOKEN@*/"Menu"/*@END_MENU_TOKEN@*/) {
                    Button("Show Dashboard") {
                        tabSelection = 1
                    }
                    Button("Show Tab 2") {
                        tabSelection = 2
                    }
                }
                .padding(10)
            }
            
        }
    }
}

#Preview {
    BottomMenuBar()
}
