//
//  MIBApp.swift
//  MIB
//
//  Created by Junyoo on 9/20/25.
//

import SwiftUI

@main
struct MIBApp: App {
    @StateObject private var appState = AppState.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .onOpenURL { url in
                    if url.scheme == "mib" || url.host == "localhost" {
                        Task {
                            await appState.handleKakaoCallback(url: url)
                        }
                    }
                }
        }
    }
}
