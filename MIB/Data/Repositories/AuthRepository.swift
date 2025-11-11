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
    
    init(
        googleSignInService: GoogleSignInService,
        kakaoAuthService: KakaoAuthService
    ) {
        self.googleSignInService = googleSignInService
        self.kakaoAuthService = kakaoAuthService
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
    
    func logout() async throws {
        
    }
}
