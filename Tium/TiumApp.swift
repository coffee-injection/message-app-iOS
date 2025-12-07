//
//  TiumApp.swift
//  Tium
//
//  Created by Junyoo on 9/20/25.
//

import SwiftUI

@main
struct TiumApp: App {
    @StateObject private var appState = AppState.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .onOpenURL { url in
                    if url.scheme == "tium" || url.host == "localhost" {
                        Task {
                            await appState.handleKakaoCallback(url: url)
                        }
                    }
                }
        }
    }
}
