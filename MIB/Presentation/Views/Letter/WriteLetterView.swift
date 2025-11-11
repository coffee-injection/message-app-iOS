//
//  WriteLetterView.swift
//  MIB
//
//  Created by JunghyunYoo on 10/26/25.
//

import SwiftUI

struct WriteLetterView: View {
    let onDismiss: () -> Void
    @StateObject private var viewModel = WriteLetterViewModel()
    
    var body: some View {
        ZStack {
            Color.white
                .cornerRadius(16)
            
            VStack(spacing: 0) {
                // 상단 헤더
                HStack {
                    Spacer()
                    
                    Button(action: {
                        viewModel.close()
                        onDismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                    .padding(.trailing, 20)
                    .padding(.top, 16)
                }
                
                // 텍스트 입력 영역
                TextEditor(text: $viewModel.letterContent)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .scrollContentBackground(.hidden)
                    .background(Color.white)
                    .font(.body)
                    .foregroundColor(.black)
                
                Spacer()
                
                // 하단 전송 버튼
                HStack {
                    Button(action: {
                        Task {
                            await viewModel.sendLetter()
                            if !viewModel.showingError {
                                onDismiss()
                            }
                        }
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "paperplane")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                            
                            Text("Send into the sea")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color("navy_main"))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                    .disabled(viewModel.isSending || viewModel.letterContent.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .opacity(viewModel.isSending || viewModel.letterContent.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.6 : 1.0)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
        }
        .frame(width: 350, height: 500)
        .alert("오류", isPresented: $viewModel.showingError) {
            Button("확인", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage ?? "편지 전송에 실패했습니다.")
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    WriteLetterView(onDismiss: {})
}

