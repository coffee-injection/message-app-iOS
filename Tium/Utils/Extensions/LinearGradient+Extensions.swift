//
//  LinearGradient+Extensions.swift
//  Tium
//
//  Created by JunghyunYoo on 12/21/25.
//

import SwiftUI

extension LinearGradient {
    static var primaryGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(hex: "2B7FFF"),
                Color(hex: "00B8DB")
            ]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}

