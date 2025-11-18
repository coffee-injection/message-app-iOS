//
//  AuthRepository.swift
//  MIB
//
//  Created by JunghyunYoo on 10/14/25.
//

import Foundation

class AuthRepository: AuthRepositoryProtocol {
    private let googleSignInService: GoogleSignInService
    private let kakaoAuthService: KakaoAuthService
    private let kakaoAuthAPIService: KakaoAuthAPIService
    
    init(
        googleSignInService: GoogleSignInService,
        kakaoAuthService: KakaoAuthService,
        kakaoAuthAPIService: KakaoAuthAPIService
    ) {
        self.googleSignInService = googleSignInService
        self.kakaoAuthService = kakaoAuthService
        self.kakaoAuthAPIService = kakaoAuthAPIService
    }
    
    func signInWithGoogle() async throws -> AuthResult {
        return try await googleSignInService.signIn()
    }
    
    func signInWithKakao() async throws -> AuthResult {
        return try await kakaoAuthService.signIn()
    }
    
    func signInWithApple() async throws -> AuthResult {
        throw AuthError.signInFailed
    }
    
    func signInWithEmail(email: String) async throws -> AuthResult {
        throw AuthError.signInFailed
    }
    
    func completeSignup(nickname: String) async throws -> AuthResult {
        let responseDTO = try await kakaoAuthAPIService.completeSignup(nickname: nickname)
        
        guard let loginData = responseDTO.data else {
            throw AuthError.signInFailed
        }
        
        TokenManager.shared.saveToken(
            accessToken: loginData.accessToken,
            tokenType: loginData.tokenType,
            expiresIn: loginData.expiresIn
        )
        
        return AuthResult(
            isSuccess: true,
            isNewMember: false,
            user: AuthUser(
                id: loginData.memberId.map { String($0) } ?? "",
                email: loginData.email,
                name: nil
            ),
            error: nil
        )
    }
    
    func logout() async throws {
        TokenManager.shared.clearToken()
    }
}
