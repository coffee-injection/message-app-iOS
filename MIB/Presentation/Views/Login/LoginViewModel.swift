//
//  LoginViewModel.swift
//  MIB
//
//  Created by JunghyunYoo on 10/14/25.
//

import Foundation
import SwiftUI
import AuthenticationServices

@MainActor
class LoginViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var email = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showingError = false
    @Published var needsNicknameSetup = false
    
    private let signInWithGoogleUseCase: SignInWithGoogleUseCaseProtocol
    private let signInWithKakaoUseCase: SignInWithKakaoUseCaseProtocol
    private let tokenManager: TokenManager
    
    init(
        signInWithGoogleUseCase: SignInWithGoogleUseCaseProtocol,
        signInWithKakaoUseCase: SignInWithKakaoUseCaseProtocol,
        tokenManager: TokenManager = .shared
    ) {
        self.signInWithGoogleUseCase = signInWithGoogleUseCase
        self.signInWithKakaoUseCase = signInWithKakaoUseCase
        self.tokenManager = tokenManager
        
        if tokenManager.getAccessToken() != nil {
            isLoggedIn = true
        }
    }
    
    func continueWithEmail() {
        print("이메일로 계속하기 버튼 클릭됨: \(email)")
        isLoggedIn = true
    }
    
    func signInWithGoogle() async {
        print("Google 로그인 버튼 클릭됨")
        isLoggedIn = true
//        isLoading = true
//        errorMessage = nil
//        
//        do {
//            let result = try await signInWithGoogleUseCase.execute()
//            if result.isSuccess {
//                isLoggedIn = true
//            } else {
//                errorMessage = result.error?.localizedDescription ?? "로그인에 실패했습니다"
//            }
//        } catch {
//            errorMessage = error.localizedDescription
//        }
//        
//        isLoading = false
    }
    
    func signInWithKakao() async {
        isLoading = true
        errorMessage = nil
        showingError = false
        needsNicknameSetup = false
        
        do {
            let result = try await signInWithKakaoUseCase.execute()
            if result.isSuccess {
                if result.isNewMember {
                    needsNicknameSetup = true
                } else {
                    await handleLoginSuccess()
                }
            } else {
                errorMessage = result.error?.localizedDescription ?? "카카오 로그인에 실패했습니다"
                showingError = true
            }
        } catch {
            errorMessage = error.localizedDescription
            showingError = true
        }
        
        isLoading = false
    }
    
    func handleNicknameSetupCompletion() {
        needsNicknameSetup = false
        Task {
            await handleLoginSuccess()
        }
    }
    
    func cancelNicknameSetup() {
        needsNicknameSetup = false
        tokenManager.clearToken()
    }
    
    private func handleLoginSuccess() async {
        if let header = tokenManager.getAuthorizationHeader() {
            print("[LoginViewModel] 저장된 토큰 확인: \(header)")
        } else {
            print("[LoginViewModel] 저장된 토큰이 없습니다")
        }
        isLoggedIn = true
    }
    
    func signInWithApple(result: Result<ASAuthorization, Error>) {
        print("Apple 로그인 버튼 클릭됨")
        isLoggedIn = true
        
//        switch result {
//        case .success(let authorization):
//            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
//                let userIdentifier = appleIDCredential.user
//                let fullName = appleIDCredential.fullName
//                let email = appleIDCredential.email
//                
//                print("Apple 로그인 성공: \(userIdentifier)")
//                isLoggedIn = true
//            }
//        case .failure(let error):
//            print("Apple 로그인 실패: \(error.localizedDescription)")
//        }
    }
}

