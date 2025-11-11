//
//  AppState.swift
//  MIB
//
//  Created by JunghyunYoo on 11/11/25.
//

import Foundation
import SwiftUI

@MainActor
class AppState: ObservableObject {
    static let shared = AppState()
    
    let kakaoAuthService: KakaoAuthService
    
    private init() {
        self.kakaoAuthService = KakaoAuthService(
            apiService: KakaoAuthAPIService()
        )
    }
    
    func handleKakaoCallback(url: URL) async {
        await kakaoAuthService.handleKakaoCallback(url: url)
    }
}

