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
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    viewModel.showBookmark()
                }) {
                    Image(systemName: "bookmark")
                        .foregroundStyle(.black)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.showProfile()
                }) {
                    Image(systemName: "person")
                        .foregroundStyle(.black)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color("sky_1"), for: .navigationBar)
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
