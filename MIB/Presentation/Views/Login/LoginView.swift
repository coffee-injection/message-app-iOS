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
                Color("navy_main")
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    Spacer()
                    
                   Text("계정 만들기")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("앱 가입하세요")
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    VStack(spacing: 16) {
                        TextField("email@domain.com", text: $viewModel.email)
                            .textFieldStyle(PlainTextFieldStyle())
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .foregroundColor(.black)
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
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color("navy_1"), Color("navy_2")]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(12)
                                .padding(.horizontal, 20)
                        }
                        
                        HStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(height: 1)
                            
                            Text("또는")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.horizontal, 16)
                            
                            Rectangle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(height: 1)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        
                        GoogleSignInButton(
                            scheme: .light,
                            style: .wide,
                            state: .normal,
                            action: {
                                Task {
                                    await viewModel.signInWithGoogle()
                                }
                            }
                        )
                        .frame(height: 40)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        
                        SignInWithAppleButton(
                            onRequest: { request in
                                request.requestedScopes = [.fullName, .email]
                            },
                            onCompletion: { result in
                                viewModel.signInWithApple(result: result)
                            }
                        )
                        .signInWithAppleButtonStyle(.white)
                        .frame(height: 40)
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
            .toolbarBackground(Color("navy_main"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }    
}

#Preview {
    LoginView()
}
