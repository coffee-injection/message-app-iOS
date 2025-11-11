//
//  KakaoAuthService.swift
//  MIB
//
//  Created by JunghyunYoo on 11/04/25.
//

import Foundation
import UIKit
import SafariServices

class KakaoAuthService {
    private let apiService: KakaoAuthAPIService
    private var safariViewController: SFSafariViewController?
    
    var onKakaoLoginComplete: ((Result<AuthResult, Error>) -> Void)?
    
    init(apiService: KakaoAuthAPIService) {
        self.apiService = apiService
    }
    
    func startKakaoLogin() async throws {
        let loginUrl = try await apiService.getKakaoLoginUrl()
        
        guard let url = URL(string: loginUrl) else {
            throw KakaoAuthError.invalidResponse
        }
        
        await MainActor.run {
            guard let presentingViewController = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .flatMap({ $0.windows })
                .first(where: { $0.isKeyWindow })?.rootViewController else {
                return
            }
            
            let safariVC = SFSafariViewController(url: url)
            safariVC.modalPresentationStyle = .pageSheet
            self.safariViewController = safariVC
            presentingViewController.present(safariVC, animated: true)
        }
    }
    
    func signIn() async throws -> AuthResult {
        try await withCheckedThrowingContinuation { continuation in
            Task {
                do {
                    self.onKakaoLoginComplete = { result in
                        switch result {
                        case .success(let authResult):
                            continuation.resume(returning: authResult)
                        case .failure(let error):
                            continuation.resume(throwing: error)
                        }
                    }
                    try await self.startKakaoLogin()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func handleKakaoCallback(url: URL) async {
        await MainActor.run {
            safariViewController?.dismiss(animated: true)
            safariViewController = nil
        }
        
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let code = components.queryItems?.first(where: { $0.name == "code" })?.value else {
            onKakaoLoginComplete?(.failure(KakaoAuthError.invalidResponse))
            return
        }
        
        do {
            let loginResponse = try await apiService.loginWithKakaoCode(code: code)
            
            let authResult = AuthResult(
                isSuccess: true,
                user: nil,
                error: nil
            )
            
            onKakaoLoginComplete?(.success(authResult))
        } catch {
            onKakaoLoginComplete?(.failure(error))
        }
    }
}

