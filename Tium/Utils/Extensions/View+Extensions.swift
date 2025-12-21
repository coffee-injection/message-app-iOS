//
//  View+Extensions.swift
//  Tium
//
//  Created by JunghyunYoo on 10/14/25.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct BackgroundSkyColor: View {
    var body: some View {
        RadialGradient(
            gradient: Gradient(stops: [
                .init(color: Color(hex: "3B82F6").opacity(0.3), location: 0),
                .init(color: Color(hex: "000000").opacity(0), location: 1)
            ]),
            center: .topLeading,
            startRadius: 0,
            endRadius: 800
        )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
