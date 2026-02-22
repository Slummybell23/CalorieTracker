//
//  DefaultTheme.swift
//  CalorieTracker
//
//  Created by Cache Salyers on 2/17/26.
//

import SwiftUI

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: Color(.systemGray4), radius: 8)
    }
}
extension View {
    func cardModifier() -> some View {
        modifier(CardModifier())
    }
}
