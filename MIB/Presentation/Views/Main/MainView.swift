//
//  MainView.swift
//  MIB
//
//  Created by JunghyunYoo on 9/30/25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        ZStack {
            Image("main_background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            VStack {
                // 상단 헤더: 프로필 이미지와 섬 이름
                HStack {
                    Button(action: {
                        viewModel.showProfile()
                    }) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.gray.opacity(0.3))

//                        if let imageUrl = viewModel.profileImageUrl, !imageUrl.isEmpty {
//                            AsyncImage(url: URL(string: imageUrl)) { image in
//                                image
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                            } placeholder: {
//                                Image(systemName: "person.circle.fill")
//                                    .font(.system(size: 40))
//                                    .foregroundColor(.gray.opacity(0.3))
//                            }
//                            .frame(width: 40, height: 40)
//                            .clipShape(Circle())
//                        } else {
//                            Image(systemName: "person.circle.fill")
//                                .font(.system(size: 40))
//                                .foregroundColor(.gray.opacity(0.3))
//                        }
                    }
                    
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
                
                Spacer()
                
                HStack(spacing: 20) {
                    ForEach(viewModel.bottles, id: \.id) { bottle in
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
                Spacer()
                    .frame(height: 200)
            }
            
            // 오른쪽 하단 글쓰기 플로팅 버튼
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
            
            if viewModel.showingMessage {
                ZStack {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            viewModel.closeMessage()
                        }
                    
                    MessageView(message: viewModel.selectedMessage, onDismiss: {
                        viewModel.closeMessage()
                    })
                }
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.3), value: viewModel.showingMessage)
            }
            
            if viewModel.showingWriteLetter {
                ZStack {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            viewModel.closeWriteLetter()
                        }
                    
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
    }
}

#Preview {
    MainView()
}
