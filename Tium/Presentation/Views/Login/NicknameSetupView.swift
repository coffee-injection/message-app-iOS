//
//  NicknameSetupView.swift
//  Tium
//
//  Created by JunghyunYoo on 11/18/25.
//

import SwiftUI

struct NicknameSetupView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: NicknameSetupViewModel
    
    let onCompleted: () -> Void
    let onCancelled: (() -> Void)?
    
    init(
        completeSignupUseCase: CompleteSignupUseCaseProtocol,
        onCompleted: @escaping () -> Void,
        onCancelled: (() -> Void)? = nil
    ) {
        _viewModel = StateObject(wrappedValue: NicknameSetupViewModel(completeSignupUseCase: completeSignupUseCase))
        self.onCompleted = onCompleted
        self.onCancelled = onCancelled
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                profileImageView
                
                VStack(spacing: 16) {
                    Text("앱에서 사용할 닉네임을 입력해주세요.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 24)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("닉네임")
                            .font(.body)
                            .foregroundColor(.primary)
                        
                        TextField("닉네임을 입력해주세요", text: $viewModel.nickname)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        Task {
                            await viewModel.submit {
                                onCompleted()
                                dismiss()
                            }
                        }
                    }) {
                        if viewModel.isSubmitting {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                        } else {
                            Text("저장하기")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                        }
                    }
                    .disabled(viewModel.isSubmitting || viewModel.nickname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .opacity(viewModel.isSubmitting || viewModel.nickname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.6 : 1.0)
                    .background(Color("navy_main"))
                    .cornerRadius(12)
                }
                .padding(.horizontal, 20)
            }
            .navigationTitle("닉네임 설정")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        onCancelled?()
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.primary)
                    }
                    .disabled(viewModel.isSubmitting)
                }
            }
            .alert("오류", isPresented: $viewModel.showingError) {
                Button("확인", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage ?? "닉네임 설정에 실패했습니다.")
            }
        }
    }
    
    @ViewBuilder
    private var profileImageView: some View {
        Image(systemName: "person.fill")
            .font(.system(size: 80))
            .foregroundColor(.gray.opacity(0.5))
            .frame(width: 120, height: 120)
            .background(Color(.systemGray6))
            .clipShape(Circle())
            .padding(.top, 40)
            .padding(.bottom, 32)
    }
}

#Preview {
    NicknameSetupView(
        completeSignupUseCase: CompleteSignupUseCase(authRepository: AuthRepository(
            googleSignInService: GoogleSignInService(),
            kakaoAuthService: KakaoAuthService(apiService: KakaoAuthAPIService()),
            kakaoAuthAPIService: KakaoAuthAPIService()
        )),
        onCompleted: {},
        onCancelled: {}
    )
}

