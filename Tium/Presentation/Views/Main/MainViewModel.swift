//
//  MainViewModel.swift
//  Tium
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
    @Published var bottles: [BottleData] = []
    @Published var isLoadingLetters = false
    @Published var letterErrorMessage: String?
    
    var profileImageUrl: String? = nil
    var islandName: String = "아보카도섬"
    
    private let getReadableLettersUseCase: GetReadableLettersUseCase
    private let tokenManager: TokenManager
    private var hasLoadedLetters = false
    
    init(
        getReadableLettersUseCase: GetReadableLettersUseCase = GetReadableLettersUseCase(repository: LetterRepository(apiService: LetterAPIService())),
        tokenManager: TokenManager = .shared
    ) {
        self.getReadableLettersUseCase = getReadableLettersUseCase
        self.tokenManager = tokenManager
    }
    
    func loadLettersIfNeeded() async {
        guard !hasLoadedLetters else { return }
        hasLoadedLetters = true
        await loadLetters()
    }
    
    func loadLetters() async {
        isLoadingLetters = true
        letterErrorMessage = nil
        
        guard tokenManager.getAuthorizationHeader() != nil else {
            letterErrorMessage = "로그인이 필요합니다."
            isLoadingLetters = false
            return
        }
        
        do {
            let letters = try await getReadableLettersUseCase.execute()
            print("[MainViewModel] letter/list 응답 개수: \(letters.count)")
            letters.enumerated().forEach { index, letter in
                print("[MainViewModel] letter[\(index)] id: \(letter.id), status: \(letter.status.rawValue), content: \(letter.content)")
            }
            bottles = letters.map { letter in
                BottleData(
                    id: letter.id,
                    message: letter.content
                )
            }
        } catch {
            letterErrorMessage = error.localizedDescription
            print("[MainViewModel] 편지 목록 조회 실패: \(error.localizedDescription)")
        }
        
        isLoadingLetters = false
    }
    
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
    let id: String
    let message: String
}
