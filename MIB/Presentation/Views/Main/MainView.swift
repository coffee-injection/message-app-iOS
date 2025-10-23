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
        NavigationStack {
            Color(.blue)
                .ignoresSafeArea()
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
                .toolbarBackground(.visible, for: .navigationBar)
                .sheet(isPresented: $viewModel.showingBookmark) {
                    BookmarkView()
                }
                .sheet(isPresented: $viewModel.showingProfile) {
                    ProfileView()
                }
        }
    }
}

#Preview {
    MainView()
}
