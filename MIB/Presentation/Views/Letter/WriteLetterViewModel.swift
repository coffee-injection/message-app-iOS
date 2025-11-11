//
//  WriteLetterViewModel.swift
//  MIB
//
//  Created by JunghyunYoo on 10/26/25.
//

import Foundation
import SwiftUI

@MainActor
class WriteLetterViewModel: ObservableObject {
    @Published var letterContent: String = ""
    @Published var isSending = false
    @Published var showingError = false
    @Published var errorMessage: String?
    
    private let sendLetterUseCase: SendLetterUseCase
    
    init(sendLetterUseCase: SendLetterUseCase? = nil) {
        // TODO: 의존성 주입으로 실제 UseCase 받기
        // 임시로 nil을 받아서 실제 구현 시 주입 필요
        self.sendLetterUseCase = sendLetterUseCase ?? DummySendLetterUseCase()
    }
    
    func close() {
        print("글쓰기 뷰 닫기")
    }
    
    func sendLetter() async {
        guard !letterContent.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "편지 내용을 입력해주세요."
            showingError = true
            return
        }
        
        isSending = true
        errorMessage = nil
        showingError = false
        
        do {
            let letter = try await sendLetterUseCase.execute(content: letterContent)
            print("편지 전송 성공: \(letter.id)")
            letterContent = ""
        } catch {
            errorMessage = error.localizedDescription
            showingError = true
        }
        
        isSending = false
    }
}

// 임시 Dummy UseCase
private class DummySendLetterUseCase: SendLetterUseCase {
    init() {
        super.init(repository: DummyLetterRepository())
    }
}

private class DummyLetterRepository: LetterRepositoryProtocol {
    func getMyLetters() async throws -> [Letter] { return [] }
    func getReadableLetters() async throws -> [Letter] { return [] }
    func getBookmarkedLetters() async throws -> [Letter] { return [] }
    func getLetter(id: String) async throws -> Letter {
        throw NSError(domain: "Dummy", code: -1)
    }
    func sendLetter(content: String) async throws -> Letter {
        // 실제 API 호출 대신 성공으로 처리
        return Letter(content: content, sender: "User")
    }
    func markAsRead(id: String) async throws {}
    func bookmarkLetter(id: String) async throws {}
    func unbookmarkLetter(id: String) async throws {}
    func deleteLetter(id: String) async throws {}
}

