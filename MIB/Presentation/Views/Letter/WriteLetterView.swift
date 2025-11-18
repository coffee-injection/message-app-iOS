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
            backgroundView
            
            VStack(spacing: 0) {
                headerView
                textEditorView
                Spacer()
                sendButtonView
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
    
    // MARK: - View Builders
    
    @ViewBuilder
    private var backgroundView: some View {
        Color.white
            .cornerRadius(16)
    }
    
    @ViewBuilder
    private var headerView: some View {
        HStack {
            Spacer()
            CloseButton(action: {
                viewModel.close()
                onDismiss()
            })
            .padding(.trailing, 20)
            .padding(.top, 16)
        }
    }
    
    @ViewBuilder
    private var textEditorView: some View {
        TextEditor(text: $viewModel.letterContent)
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .scrollContentBackground(.hidden)
            .background(Color.white)
            .font(.body)
            .foregroundColor(.black)
    }
    
    @ViewBuilder
    private var sendButtonView: some View {
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
                    
                    Text("바다로 보내기")
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

#Preview {
    WriteLetterView(onDismiss: {})
}

