//
//  GoogleSignInService.swift
//  MIB
//
//  Created by JunghyunYoo on 10/14/25.
//

import Foundation
import GoogleSignIn

class GoogleSignInService {
    func signIn() async throws -> AuthResult {
        guard let presentingViewController = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow })?.rootViewController else {
            throw AuthError.noPresentingViewController
        }
        
        do {
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController)
            let user = result.user
            
            return AuthResult(
                isSuccess: true,
                user: AuthUser(
                    id: user.userID ?? "",
                    email: user.profile?.email ?? "",
                    name: user.profile?.name
                ),
                error: nil
            )
        } catch {
            return AuthResult(
                isSuccess: false,
                user: nil,
                error: error
            )
        }
    }
}

enum AuthError: Error, LocalizedError {
    case noPresentingViewController
    case signInFailed
    
    var errorDescription: String? {
        switch self {
        case .noPresentingViewController:
            return "Presenting view controller not found"
        case .signInFailed:
            return "Sign in failed"
        }
    }
}
