//
//  KakaoAuthService.swift
//  Tium
//
//  Created by JunghyunYoo on 11/04/25.
//

import Foundation
import UIKit

class KakaoAuthService {
    private let apiService: KakaoAuthAPIService
    private var loginNavigationController: UINavigationController?
    
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
            
            let webViewController = KakaoLoginWebViewController(url: url)
            webViewController.onClose = { [weak self] in
                Task {
                    await self?.dismissLoginInterface()
                }
            }
            webViewController.onCodeExtracted = { [weak self] code in
                Task {
                    await self?.dismissLoginInterface()
                    await self?.handleAuthorizationCode(code)
                }
            }
            
            let navigationController = UINavigationController(rootViewController: webViewController)
            navigationController.modalPresentationStyle = .formSheet
            
            self.loginNavigationController = navigationController
            presentingViewController.present(navigationController, animated: true)
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
        print("[KakaoAuth] 콜백 URL 수신: \(url.absoluteString)")
        
        await dismissLoginInterface()
        
        guard let code = extractAuthorizationCode(from: url) else {
            print("[KakaoAuth] 콜백 URL에서 code 추출 실패")
            onKakaoLoginComplete?(.failure(KakaoAuthError.invalidResponse))
            return
        }
        
        await handleAuthorizationCode(code)
    }

    @MainActor
    private func dismissLoginInterface() {
        loginNavigationController?.dismiss(animated: true)
        loginNavigationController = nil
    }
    
    private func extractAuthorizationCode(from url: URL) -> String? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let code = components.queryItems?.first(where: { $0.name == "code" })?.value else {
            return nil
        }
        return code
    }
    
    private func handleAuthorizationCode(_ code: String) async {
        print("[KakaoAuth] 추출된 code: \(code)")
        
        do {
            let loginResponse = try await apiService.loginWithKakaoCode(code: code)
            
            guard let loginData = loginResponse.data else {
                onKakaoLoginComplete?(.failure(KakaoAuthError.invalidResponse))
                return
            }
            
            TokenManager.shared.saveToken(
                accessToken: loginData.accessToken,
                tokenType: loginData.tokenType,
                expiresIn: loginData.expiresIn
            )
            
            if let header = TokenManager.shared.getAuthorizationHeader() {
                print("[KakaoAuth] 토큰 저장 완료: \(header)")
            } else {
                print("[KakaoAuth] 토큰 저장 실패")
            }
            
            let authResult = AuthResult(
                isSuccess: true,
                isNewMember: loginData.isNewMember,
                user: AuthUser(
                    id: loginData.memberId.map { String($0) } ?? "",
                    email: loginData.email,
                    name: nil
                ),
                error: nil
            )
            
            onKakaoLoginComplete?(.success(authResult))
        } catch {
            onKakaoLoginComplete?(.failure(error))
        }
    }
}