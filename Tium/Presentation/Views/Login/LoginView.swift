//
//  LoginView.swift
//  Tium
//
//  Created by JunghyunYoo on 9/30/25.
//

import SwiftUI
import AuthenticationServices
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {
    @EnvironmentObject private var appState: AppState
    @StateObject private var viewModel: LoginViewModel
    
    init() {
        let appState = AppState.shared
        _viewModel = StateObject(wrappedValue: LoginViewModel(
            signInWithGoogleUseCase: appState.signInWithGoogleUseCase,
            signInWithKakaoUseCase: appState.signInWithKakaoUseCase
        ))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundSkyColor()
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    Spacer()
                    
                    topSection
                    
                    Spacer()
                    
                    loginButtonsSection
                    
                    footerText
                        .padding(.top, 24)
                        .padding(.bottom, 40)
                }
            }
            .navigationDestination(isPresented: $viewModel.isLoggedIn) {
                MainView()
            }
            .navigationDestination(isPresented: $viewModel.needsNicknameSetup) {
                NicknameSetupView(
                    completeSignupUseCase: appState.completeSignupUseCase,
                    onCompleted: {
                        viewModel.handleNicknameSetupCompletion()
                    },
                    onCancelled: {
                        viewModel.cancelNicknameSetup()
                    }
                )
            }
            .alert("오류", isPresented: $viewModel.showingError) {
                Button("확인", role: .cancel) {
                    viewModel.errorMessage = nil
                }
            } message: {
                Text(viewModel.errorMessage ?? "오류가 발생했습니다.")
            }
            .toolbarBackground(Color.clear, for: .navigationBar)
        }
    }
    
    // MARK: - View Builders
        
    @ViewBuilder
    private var topSection: some View {
        VStack(spacing: 16) {
            Image("ic_island_daytime")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
            
            Text("Tium")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.black)
            
            VStack(spacing: 4) {
                Text("바다 위 섬들 사이로")
                    .font(.system(size: 16))
                    .foregroundColor(.black.opacity(0.7))
                
                Text("당신의 이야기를 띄워보세요")
                    .font(.system(size: 16))
                    .foregroundColor(.black.opacity(0.7))
            }
        }
    }
    
    @ViewBuilder
    private var loginButtonsSection: some View {
        VStack(spacing: 12) {
            googleSignInButton
            kakaoSignInButton
            appleSignInButton
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private var kakaoSignInButton: some View {
        Button(action: {
            Task {
                await viewModel.signInWithKakao()
            }
        }) {
            HStack(spacing: 12) {
                Image(systemName: "message.fill")
                    .font(.system(size: 18))
                Text("카카오로 계속하기")
                    .font(.system(size: 16, weight: .medium))
            }
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color(red: 1.0, green: 0.9, blue: 0.0))
            .cornerRadius(12)
        }
        .disabled(viewModel.isLoading)
        .opacity(viewModel.isLoading ? 0.6 : 1.0)
    }
    
    @ViewBuilder
    private var googleSignInButton: some View {
        Button(action: {
            Task {
                await viewModel.signInWithGoogle()
            }
        }) {
            HStack(spacing: 12) {
                Image("ic_google")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text("Google로 계속하기")
                    .font(.system(size: 16, weight: .medium))
            }
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(.white)
            .cornerRadius(12)
        }
        .disabled(viewModel.isLoading)
        .opacity(viewModel.isLoading ? 0.6 : 1.0)
    }
    
    @ViewBuilder
    private var appleSignInButton: some View {
        SignInWithAppleButton(
            onRequest: { request in
                request.requestedScopes = [.fullName, .email]
            },
            onCompletion: { result in
                viewModel.signInWithApple(result: result)
            }
        )
        .signInWithAppleButtonStyle(.black)
        .frame(height: 56)
        .cornerRadius(12)
    }
    
    @ViewBuilder
    private var footerText: some View {
        Text("계속 진행하려면 개인정보 처리방침 및 이용약관에 동의하는 것으로 간주됩니다.")
            .font(.system(size: 12))
            .foregroundColor(.black.opacity(0.5))
            .multilineTextAlignment(.center)
            .padding(.horizontal, 40)
    }
}

#Preview {
    LoginView()
        .environmentObject(AppState.shared)
}
