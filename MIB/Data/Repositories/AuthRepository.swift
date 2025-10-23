//
//  AuthRepository.swift
//  MIB
//
//  Created by JunghyunYoo on 10/14/25.
//

import Foundation

class AuthRepository: AuthRepositoryProtocol {
    private let googleSignInService: GoogleSignInService
    
    init(googleSignInService: GoogleSignInService) {
        self.googleSignInService = googleSignInService
    }
    
    func signInWithGoogle() async throws -> AuthResult {
        return try await googleSignInService.signIn()
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
