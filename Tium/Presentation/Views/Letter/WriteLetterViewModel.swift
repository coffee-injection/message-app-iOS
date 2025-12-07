//
//  WriteLetterViewModel.swift
//  Tium
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
    private let tokenManager: TokenManager
    
    init(
        sendLetterUseCase: SendLetterUseCase? = nil,
        tokenManager: TokenManager = .shared
    ) {
        if let sendLetterUseCase {
            self.sendLetterUseCase = sendLetterUseCase
        } else {
            let repository = LetterRepository(apiService: LetterAPIService())
            self.sendLetterUseCase = SendLetterUseCase(repository: repository)
        }
        self.tokenManager = tokenManager
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
        
        guard tokenManager.getAuthorizationHeader() != nil else {
            errorMessage = "로그인이 필요합니다."
            showingError = true
            isSending = false
            return
        }
        
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

