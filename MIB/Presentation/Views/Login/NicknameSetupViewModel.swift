//
//  NicknameSetupViewModel.swift
//  MIB
//
//  Created by JunghyunYoo on 11/18/25.
//

import Foundation
import SwiftUI

@MainActor
class NicknameSetupViewModel: ObservableObject {
    @Published var nickname: String = ""
    @Published var isSubmitting = false
    @Published var showingError = false
    @Published var errorMessage: String?
    
    private let completeSignupUseCase: CompleteSignupUseCaseProtocol
    
    init(completeSignupUseCase: CompleteSignupUseCaseProtocol) {
        self.completeSignupUseCase = completeSignupUseCase
    }
    
    func submit(onSuccess: @escaping () -> Void) async {
        let trimmedNickname = nickname.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedNickname.isEmpty else {
            errorMessage = "닉네임을 입력해주세요."
            showingError = true
            return
        }
        
        isSubmitting = true
        errorMessage = nil
        showingError = false
        
        do {
            let result = try await completeSignupUseCase.execute(nickname: trimmedNickname)
            if result.isSuccess {
                onSuccess()
            } else {
                errorMessage = result.error?.localizedDescription ?? "닉네임 설정에 실패했습니다."
                showingError = true
            }
        } catch {
            errorMessage = error.localizedDescription
            showingError = true
        }
        
        isSubmitting = false
    }
}

