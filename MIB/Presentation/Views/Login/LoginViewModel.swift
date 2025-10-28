//
//  LoginViewModel.swift
//  MIB
//
//  Created by JunghyunYoo on 10/14/25.
//

import Foundation
import SwiftUI
import AuthenticationServices

@MainActor
class LoginViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var email = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let signInWithGoogleUseCase: SignInWithGoogleUseCaseProtocol
    
    init(signInWithGoogleUseCase: SignInWithGoogleUseCaseProtocol) {
        self.signInWithGoogleUseCase = signInWithGoogleUseCase
    }
    
    func continueWithEmail() {
        print("이메일로 계속하기 버튼 클릭됨: \(email)")
        isLoggedIn = true
    }
    
    func signInWithGoogle() async {
        print("Google 로그인 버튼 클릭됨")
        isLoggedIn = true
//        isLoading = true
//        errorMessage = nil
//        
//        do {
//            let result = try await signInWithGoogleUseCase.execute()
//            if result.isSuccess {
//                isLoggedIn = true
//            } else {
//                errorMessage = result.error?.localizedDescription ?? "로그인에 실패했습니다"
//            }
//        } catch {
//            errorMessage = error.localizedDescription
//        }
//        
//        isLoading = false
    }
    
    func signInWithApple(result: Result<ASAuthorization, Error>) {
        print("Apple 로그인 버튼 클릭됨")
        isLoggedIn = true
        
//        switch result {
//        case .success(let authorization):
//            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
//                let userIdentifier = appleIDCredential.user
//                let fullName = appleIDCredential.fullName
//                let email = appleIDCredential.email
//                
//                print("Apple 로그인 성공: \(userIdentifier)")
//                isLoggedIn = true
//            }
//        case .failure(let error):
//            print("Apple 로그인 실패: \(error.localizedDescription)")
//        }
    }
}

