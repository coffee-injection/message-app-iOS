//
//  MainView.swift
//  MIB
//
//  Created by JunghyunYoo on 9/30/25.
//

import SwiftUI

struct MainView: View {
    @State private var showingBookmark = false
    @State private var showingProfile = false
    
    var body: some View {
        NavigationStack {
            Color(.blue)
                .ignoresSafeArea()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            showingBookmark = true
                        }) {
                            Image(systemName: "bookmark")
                                .foregroundStyle(.black)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showingProfile = true
                        }) {
                            Image(systemName: "person")
                                .foregroundStyle(.black)
                        }
                    }
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
                .sheet(isPresented: $showingBookmark) {
                    BookmarkView()
                }
                .sheet(isPresented: $showingProfile) {
                    ProfileView()
                }
        }
    }
}

#Preview {
    MainView()
        .modelContainer(for: Item.self, inMemory: true)
}
