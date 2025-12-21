//
//  NicknameSetupViewModel.swift
//  Tium
//
//  Created by JunghyunYoo on 11/18/25.
//

import Foundation
import SwiftUI

@MainActor
class NicknameSetupViewModel: ObservableObject {
    @Published var islandName: String = ""
    @Published var nickname: String = ""
    @Published var selectedEmoji: String = "🌸"
    @Published var categoryType: CategoryType = .island
    @Published var isSubmitting = false
    @Published var showingError = false
    @Published var errorMessage: String?
    
    enum CategoryType: String, CaseIterable {
        case province = "도"
        case island = "섬"
    }
    
    let availableEmojis = ["🌸", "🌊", "🌙", "⭐", "🌺", "🦋", "🐚", "🌴", "🌻", "🍀", "🌵", "⚖️"]
    
    private let completeSignupUseCase: CompleteSignupUseCaseProtocol
    
    init(completeSignupUseCase: CompleteSignupUseCaseProtocol) {
        self.completeSignupUseCase = completeSignupUseCase
    }
    
    func submit(onSuccess: @escaping () -> Void) async {
        let trimmedNickname = nickname.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedIslandName = islandName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedNickname.isEmpty else {
            errorMessage = "닉네임을 입력해주세요."
            showingError = true
            return
        }
        
        guard !trimmedIslandName.isEmpty else {
            errorMessage = "섬 이름을 입력해주세요."
            showingError = true
            return
        }
        
        isSubmitting = true
        errorMessage = nil
        showingError = false
        
        do {
            let requestDTO = CompleteSignupRequestDTO(
                emoji: selectedEmoji,
                islandName: trimmedIslandName,
                categoryType: categoryType.rawValue,
                nickname: trimmedNickname
            )
            
            let result = try await completeSignupUseCase.execute(requestDTO: requestDTO)
            if result.isSuccess {
                UserProfileManager.shared.saveProfile(
                    emoji: selectedEmoji,
                    islandName: trimmedIslandName,
                    categoryType: categoryType.rawValue,
                    nickname: trimmedNickname
                )
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

