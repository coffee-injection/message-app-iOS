//
//  SignInWithGoogleUseCase.swift
//  MIB
//
//  Created by JunghyunYoo on 10/14/25.
//

import Foundation

protocol SignInWithGoogleUseCaseProtocol {
    func execute() async throws -> AuthResult
}

class SignInWithGoogleUseCase: SignInWithGoogleUseCaseProtocol {
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
    
    func execute() async throws -> AuthResult {
        return try await authRepository.signInWithGoogle()
    }
}

struct AuthResult {
    let isSuccess: Bool
    let isNewMember: Bool
    let user: AuthUser?
    let error: Error?
}

struct AuthUser {
    let id: String
    let email: String
    let name: String?
}
