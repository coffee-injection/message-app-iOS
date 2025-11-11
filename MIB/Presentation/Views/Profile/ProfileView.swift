//
//  ProfileView.swift
//  MIB
//
//  Created by JunghyunYoo on 9/30/25.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        ZStack {
            backgroundColor
            
            VStack(spacing: 30) {
                Spacer()
                profileSection
                Spacer()
                menuButtonsSection
                Spacer()
                logoutButton
                versionText
            }
        }
        .navigationTitle("My Page")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationBackButton(action: {
                    viewModel.goBack()
                    dismiss()
                })
            }
        }
    }
    
    // MARK: - View Builders
    
    @ViewBuilder
    private var backgroundColor: some View {
        Color(red: 0.95, green: 0.97, blue: 1.0)
            .ignoresSafeArea()
    }
    
    @ViewBuilder
    private var profileSection: some View {
        VStack(spacing: 16) {
            ZStack {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.gray.opacity(0.3))
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.editProfile()
                        }) {
                            Image(systemName: "pencil")
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                                .frame(width: 24, height: 24)
                                .background(Color.blue)
                                .clipShape(Circle())
                        }
                    }
                }
                .frame(width: 100, height: 100)
            }
            
            Text("Ethan")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Text("@ethan_sea")
                .font(.body)
                .foregroundColor(.gray)
        }
    }
    
    @ViewBuilder
    private var menuButtonsSection: some View {
        VStack(spacing: 12) {
            menuButton(
                icon: "bookmark",
                title: "Bookmarks",
                action: { viewModel.showBookmarks() }
            )
            
            menuButton(
                icon: "gearshape",
                title: "Settings",
                action: { viewModel.showSettings() }
            )
        }
    }
    
    @ViewBuilder
    private func menuButton(icon: String, title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.black)
                
                Text(title)
                    .font(.body)
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .padding(.horizontal, 20)
        }
    }
    
    @ViewBuilder
    private var logoutButton: some View {
        Button(action: {
            viewModel.logout()
        }) {
            HStack {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.title2)
                    .foregroundColor(.black)
                
                Text("Logout")
                    .font(.body)
                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .padding(.horizontal, 20)
        }
    }
    
    @ViewBuilder
    private var versionText: some View {
        Text("Version 1.0.0")
            .font(.caption)
            .foregroundColor(.gray)
            .padding(.bottom, 20)
    }
}

#Preview {
    ProfileView()
}
