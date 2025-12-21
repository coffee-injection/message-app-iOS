//
//  MainView.swift
//  Tium
//
//  Created by JunghyunYoo on 9/30/25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    @State private var islandOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            backgroundImage
            
            VStack(spacing: 0) {
                headerView
                Spacer()
                islandView
                bottleListView
                Spacer()
                    .frame(height: 200)
            }
            
            floatingActionButton
            
            if viewModel.showingMessage {
                DimmedOverlay(onDismiss: {
                    viewModel.closeMessage()
                }) {
                    MessageView(message: viewModel.selectedMessage, onDismiss: {
                        viewModel.closeMessage()
                    })
                }
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.3), value: viewModel.showingMessage)
            }
            
            if viewModel.showingWriteLetter {
                DimmedOverlay(onDismiss: {
                    viewModel.closeWriteLetter()
                }) {
                    WriteLetterView(onDismiss: {
                        viewModel.closeWriteLetter()
                    })
                }
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.3), value: viewModel.showingWriteLetter)
            }
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $viewModel.showingBookmark) {
            BookmarkView()
        }
        .sheet(isPresented: $viewModel.showingProfile) {
            ProfileView()
        }
        .task {
            await viewModel.loadLettersIfNeeded()
        }
    }
    
    // MARK: - View Builders
    
    @ViewBuilder
    private var backgroundImage: some View {
        Image("bg_daytime")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
    }
    
    @ViewBuilder
    private var headerView: some View {
        HStack {
            Button(action: {
                viewModel.showProfile()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.9))
                        .frame(width: 60, height: 60)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                        .shadow(color: .black.opacity(0.1), radius: 16, x: 0, y: 8)
                    
                    Text("🌸")
                        .font(.system(size: 32))
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.islandName)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                
                HStack(spacing: 8) {
                    Text(Date().toKoreanMonthDay())
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.9))
                    
                    Circle()
                        .fill(Color.white.opacity(0.9))
                        .frame(width: 2, height: 2)
                    
                    Text("받은 메시지 2개")
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.9))
                }
            }
            Spacer()
        }
        .padding(.leading, 56 + 20)
    }
    
    @ViewBuilder
    private var islandView: some View {
        Image("ic_island_daytime")
            .overlay {
                Text("도마도")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.white.opacity(0.95))
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                    )
                    .offset(y: 120)
            }
            .offset(y: islandOffset)
            .onAppear {
                withAnimation(
                    Animation.easeInOut(duration: 1.0)
                        .repeatForever(autoreverses: true)
                ) {
                    islandOffset = -10
                }
            }
    }
    
    @ViewBuilder
    private var bottleListView: some View {
        if viewModel.isLoadingLetters {
            ProgressView()
                .progressViewStyle(.circular)
                .tint(.white)
        } else if let errorMessage = viewModel.letterErrorMessage {
            Text("불러오기 실패: \(errorMessage)")
                .font(.callout)
                .foregroundColor(.white)
        } else if viewModel.bottles.isEmpty {
            Text("도착한 편지가 없어요")
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))
        } else {
            HStack(spacing: 20) {
                ForEach(viewModel.bottles) { bottle in
                    Button(action: {
                        viewModel.openBottle(bottle)
                    }) {
                        Image("ic_bottle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 90)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var floatingActionButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    viewModel.showWriteLetter()
                }) {
                    Image("ic_floating_write")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                }
            }
            .padding(.trailing, 56 + 20)
        }
    }
}

#Preview {
    MainView()
}
