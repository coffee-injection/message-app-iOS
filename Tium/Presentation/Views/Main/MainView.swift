//
//  MainView.swift
//  Tium
//
//  Created by JunghyunYoo on 9/30/25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        ZStack {
            backgroundImage
            
            VStack {
                headerView
                Spacer()
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
        .navigationBarTitleDisplayMode(.inline)
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
        Image("main_background")
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
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.gray.opacity(0.3))
            }
            .padding(.leading, 50)
            
            Text(viewModel.islandName)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Spacer()
            
            Button(action: {
                viewModel.showBookmark()
            }) {
                Image(systemName: "bookmark")
                    .font(.title2)
                    .foregroundStyle(.black)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
        .padding(.bottom, 10)
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
                        Image("bottle")
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
                    Image("floatingButton")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 56, height: 56)
                }
            }
            .padding(.trailing, 56 + 20)
            .padding(.bottom, 30)
        }
    }
}

#Preview {
    MainView()
}
