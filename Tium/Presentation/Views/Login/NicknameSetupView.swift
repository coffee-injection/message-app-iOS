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
            ZStack {
                BackgroundSkyColor()
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 0) {
                        topSection
                        
                        inputSection
                            .padding(.top, 32)
                        
                        profilePreviewSection
                            .padding(.top, 32)
                        
                        infoSection
                            .padding(.top, 32)
                        
                        actionButtonsSection
                            .padding(.top, 32)
                            .padding(.bottom, 40)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        onCancelled?()
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                    .disabled(viewModel.isSubmitting)
                }
            }
            .alert("오류", isPresented: $viewModel.showingError) {
                Button("확인", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage ?? "설정에 실패했습니다.")
            }
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
                .padding(.top, 40)
            
            Text("섬 설정")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
            
            Text("당신의 섬을 만들어주세요")
                .font(.system(size: 16))
                .foregroundColor(.black.opacity(0.7))
        }
    }
    
    @ViewBuilder
    private var inputSection: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 12) {
                Text("프로필 이모지")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 6), spacing: 12) {
                    ForEach(viewModel.availableEmojis, id: \.self) { emoji in
                        Button(action: {
                            viewModel.selectedEmoji = emoji
                        }) {
                            ZStack {
                                if viewModel.selectedEmoji == emoji {
                                    LinearGradient.primaryGradient
                                }
                                Text(emoji)
                                    .font(.system(size: 32))
                            }
                            .frame(width: 60, height: 60)
                            .cornerRadius(12)
                        }
                    }
                }
            }
            
            // 섬 이름 입력
            VStack(alignment: .leading, spacing: 12) {
                Text("섬 이름")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                
                TextField("예: 제주, 평화로운, 작은...", text: $viewModel.islandName)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            
            // 구분 선택
            VStack(alignment: .leading, spacing: 12) {
                Text("구분")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                
                HStack(spacing: 12) {
                    ForEach(NicknameSetupViewModel.CategoryType.allCases, id: \.self) { category in
                        Button(action: {
                            viewModel.categoryType = category
                        }) {
                            Text(category.rawValue)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                                .background(
                                    viewModel.categoryType == category
                                        ? Color(hex: "2B7FFF").opacity(0.2)
                                        : Color.clear
                                )
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(
                                            viewModel.categoryType == category
                                                ? Color(hex: "2B7FFF")
                                                : Color.gray.opacity(0.3),
                                            lineWidth: viewModel.categoryType == category ? 2 : 1
                                        )
                                )
                        }
                    }
                }
            }
            
            // 닉네임 입력
            VStack(alignment: .leading, spacing: 12) {
                Text("닉네임")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                
                TextField("예: 바다사랑, 파도타기, 섬지기...", text: $viewModel.nickname)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
        }
    }
    
    @ViewBuilder
    private var profilePreviewSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("프로필 미리보기")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            
            HStack(spacing: 16) {
                Text(viewModel.selectedEmoji)
                    .font(.system(size: 48))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(viewModel.islandName.isEmpty ? "" : viewModel.islandName)\(viewModel.categoryType == .island ? "섬" : "도")")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("닉네임: \(viewModel.nickname.isEmpty ? "" : viewModel.nickname)")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.9))
                }
                
                Spacer()
            }
        }
        .padding(20)
        .background(LinearGradient.primaryGradient)
        .cornerRadius(16)
    }
    
    @ViewBuilder
    private var infoSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("💡섬 이름과 닉네임")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.blue)
                    .bold()
                
                Text("섬 이름은 위치 정보로, 닉네임은 메시지에 표시됩니다")
                    .font(.system(size: 12))
                    .foregroundColor(.blue)
            }
            .padding(.leading, 20)
            Spacer()
        }
    }
    
    @ViewBuilder
    private var actionButtonsSection: some View {
        VStack(spacing: 16) {
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
                        .frame(height: 56)
                } else {
                    Text("시작하기")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                }
            }
            .disabled(viewModel.isSubmitting || viewModel.nickname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.islandName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            .opacity(viewModel.isSubmitting || viewModel.nickname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.islandName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.6 : 1.0)
            .background(LinearGradient.primaryGradient)
            .cornerRadius(12)
            
            Button(action: {
                onCancelled?()
                dismiss()
            }) {
                Text("뒤로가기")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
            }
            .disabled(viewModel.isSubmitting)
        }
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
