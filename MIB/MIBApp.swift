//
//  MIBApp.swift
//  MIB
//
//  Created by Junyoo on 9/20/25.
//

import SwiftUI

@main
struct MIBApp: App {
    private let kakaoAuthService = KakaoAuthService(
        apiService: KakaoAuthAPIService()
    )
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    if url.scheme == "mib" || url.host == "localhost" {
                        Task {
                            await kakaoAuthService.handleKakaoCallback(url: url)
                        }
                    }
                }
        }
    }
}
