//
//  MainViewModel.swift
//  MIB
//
//  Created by JunghyunYoo on 10/14/25.
//

import Foundation
import SwiftUI

@MainActor
class MainViewModel: ObservableObject {
    @Published var showingBookmark = false
    @Published var showingProfile = false
    
    func showBookmark() {
        print("북마크 버튼 클릭")
        showingBookmark = true
    }
    
    func showProfile() {
        print("프로필 버튼 클릭")
        showingProfile = true
    }
}
