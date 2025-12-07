//
//  NavigationBackButton.swift
//  Tium
//
//  Created by JunghyunYoo on 11/11/25.
//

import SwiftUI

struct NavigationBackButton: View {
    let action: () -> Void
    var tint: Color = .black
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.left")
                .foregroundColor(tint)
        }
    }
}

#Preview {
    NavigationBackButton(action: {})
}
