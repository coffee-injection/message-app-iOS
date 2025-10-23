//
//  LoginView.swift
//  MIB
//
//  Created by JunghyunYoo on 9/30/25.
//

import SwiftUI
import AuthenticationServices
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel(
        signInWithGoogleUseCase: SignInWithGoogleUseCase(
            authRepository: AuthRepository(
                googleSignInService: GoogleSignInService()
            )
        )
    )
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.95, green: 0.97, blue: 1.0)
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    Spacer()
                    
                   Text("계정 만들기")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Text("앱 가입하세요")
                        .font(.body)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    VStack(spacing: 16) {
                        TextField("email@domain.com", text: $viewModel.email)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                            .padding(.horizontal, 20)
                        
                        Button(action: {
                            viewModel.continueWithEmail()
                        }) {
                            Text("계속")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.black)
                                .cornerRadius(12)
                                .padding(.horizontal, 20)
                        }
                        
                        Text("또는")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.vertical, 8)
                        
                        GoogleSignInButton(action: {
                            Task {
                                await viewModel.signInWithGoogle()
                            }
                        })
                        .frame(height: 50)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        
                        SignInWithAppleButton(
                            onRequest: { request in
                                request.requestedScopes = [.fullName, .email]
                            },
                            onCompletion: { result in
                                switch result {
                                case .success(let authorization):
                                    viewModel.signInWithApple()
                                    if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                                        let userIdentifier = appleIDCredential.user
                                        let fullName = appleIDCredential.fullName
                                        let email = appleIDCredential.email
                                        
                                        viewModel.isLoggedIn = true
                                    }
                                case .failure(let error):
                                    print("\(error.localizedDescription)")
                                }
                            }
                        )
                        .signInWithAppleButtonStyle(.white)
                        .frame(height: 50)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    }
                    
                    Spacer()
                    
                    Text("서비스 이용 약관 및 개인정보 처리방침에 동의~~")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 20)
                }
            }
            .navigationDestination(isPresented: $viewModel.isLoggedIn) {
                MainView()
            }
        }
    }
}

#Preview {
    LoginView()
}
