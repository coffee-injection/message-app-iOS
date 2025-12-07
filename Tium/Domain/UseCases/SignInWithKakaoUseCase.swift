//
//  SignInWithKakaoUseCase.swift
//  Tium
//
//  Created by JunghyunYoo on 11/11/25.
//

import Foundation

protocol SignInWithKakaoUseCaseProtocol {
    func execute() async throws -> AuthResult
}

class SignInWithKakaoUseCase: SignInWithKakaoUseCaseProtocol {
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
    
    func execute() async throws -> AuthResult {
        return try await authRepository.signInWithKakao()
    }
}

