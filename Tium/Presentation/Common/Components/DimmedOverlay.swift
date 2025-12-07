//
//  DimmedOverlay.swift
//  Tium
//
//  Created by JunghyunYoo on 11/11/25.
//

import SwiftUI

struct DimmedOverlay<Content: View>: View {
    let onDismiss: () -> Void
    let content: Content
    
    init(onDismiss: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.onDismiss = onDismiss
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    onDismiss()
                }
            
            content
        }
    }
}

#Preview {
    DimmedOverlay(onDismiss: {}) {
        Text("Overlay Content")
            .padding()
            .background(Color.white)
            .cornerRadius(12)
    }
}
