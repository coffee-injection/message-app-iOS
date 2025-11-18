//
//  CompleteSignupUseCase.swift
//  MIB
//
//  Created by JunghyunYoo on 11/11/25.
//

import Foundation

protocol CompleteSignupUseCaseProtocol {
    func execute(nickname: String) async throws -> AuthResult
}

class CompleteSignupUseCase: CompleteSignupUseCaseProtocol {
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
    
    func execute(nickname: String) async throws -> AuthResult {
        return try await authRepository.completeSignup(nickname: nickname)
    }
}

