//
//  AppState.swift
//  MIB
//
//  Created by JunghyunYoo on 11/11/25.
//

import Foundation
import SwiftUI

@MainActor
class AppState: ObservableObject {
    static let shared = AppState()
    
    // MARK: - Services
    let kakaoAuthService: KakaoAuthService
    let authRepository: AuthRepository
    
    // MARK: - UseCases
    let signInWithGoogleUseCase: SignInWithGoogleUseCase
    let signInWithKakaoUseCase: SignInWithKakaoUseCase
    let completeSignupUseCase: CompleteSignupUseCase
    
    private init() {
        // Services 초기화
        let kakaoAuthAPIService = KakaoAuthAPIService()
        self.kakaoAuthService = KakaoAuthService(apiService: kakaoAuthAPIService)
        
        self.authRepository = AuthRepository(
            googleSignInService: GoogleSignInService(),
            kakaoAuthService: kakaoAuthService,
            kakaoAuthAPIService: kakaoAuthAPIService
        )
        
        // UseCases 초기화
        self.signInWithGoogleUseCase = SignInWithGoogleUseCase(
            authRepository: authRepository
        )
        self.signInWithKakaoUseCase = SignInWithKakaoUseCase(
            authRepository: authRepository
        )
        self.completeSignupUseCase = CompleteSignupUseCase(
            authRepository: authRepository
        )
    }
    
    func handleKakaoCallback(url: URL) async {
        await kakaoAuthService.handleKakaoCallback(url: url)
    }
}

