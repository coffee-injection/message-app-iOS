//
//  LoginViewModel.swift
//  MIB
//
//  Created by JunghyunYoo on 10/14/25.
//

import Foundation
import SwiftUI

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
        isLoading = true
        errorMessage = nil
        
        do {
            let result = try await signInWithGoogleUseCase.execute()
            if result.isSuccess {
                isLoggedIn = true
            } else {
                errorMessage = result.error?.localizedDescription ?? "로그인에 실패했습니다"
            }
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func signInWithApple() {
        print("Apple 로그인 버튼 클릭됨")
        // Apple Sign In 구현? API?
    }
}

