//
//  CloseButton.swift
//  Tium
//
//  Created by JunghyunYoo on 11/11/25.
//

import SwiftUI

struct CloseButton: View {
    let action: () -> Void
    var size: CGFloat = 20
    var weight: Font.Weight = .semibold
    var tint: Color = .black
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "xmark")
                .font(.system(size: size, weight: weight))
                .foregroundColor(tint)
        }
    }
}

#Preview {
    CloseButton(action: {})
}
