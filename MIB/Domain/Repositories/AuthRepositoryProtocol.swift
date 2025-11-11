//
//  AuthRepositoryProtocol.swift
//  MIB
//
//  Created by JunghyunYoo on 10/14/25.
//

import Foundation

protocol AuthRepositoryProtocol {
    func signInWithGoogle() async throws -> AuthResult
    func signInWithKakao() async throws -> AuthResult
    func signInWithApple() async throws -> AuthResult
    func signInWithEmail(email: String) async throws -> AuthResult
    func logout() async throws
}
