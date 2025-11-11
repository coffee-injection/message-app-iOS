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
    @Published var showingMessage = false
    @Published var selectedMessage = ""
    @Published var showingWriteLetter = false
    
    var profileImageUrl: String? = nil
    var islandName: String = "아보카도섬"
    
    let bottles = [
        BottleData(id: 1, message: "메시지 1")
    ]
    
    func showBookmark() {
        print("북마크 버튼 클릭")
        showingBookmark = true
    }
    
    func showProfile() {
        print("프로필 버튼 클릭")
        showingProfile = true
    }
    
    func openBottle(_ bottle: BottleData) {
        print("Bottle 클릭됨: \(bottle.id)")
        selectedMessage = bottle.message
        showingMessage = true
    }
    
    func closeMessage() {
        print("메시지 닫기")
        showingMessage = false
    }
    
    func showWriteLetter() {
        print("글쓰기 버튼 클릭")
        showingWriteLetter = true
    }
    
    func closeWriteLetter() {
        print("글쓰기 뷰 닫기")
        showingWriteLetter = false
    }
}

struct BottleData: Identifiable {
    let id: Int
    let message: String
}
