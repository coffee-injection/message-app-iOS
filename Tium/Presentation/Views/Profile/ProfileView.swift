//
//  ProfileView.swift
//  Tium
//
//  Created by JunghyunYoo on 9/30/25.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ProfileViewModel()
    @State private var isNotificationEnabled = true
    
    var body: some View {
        ZStack {
            BackgroundSkyColor()
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    profileCard
                    
                    bookmarkedMessagesCard
                    
                    settingsSection
                    
                    appVersionCard
                    
                    logoutButton
                }
                .padding(.horizontal, 20)
            }
        }
        .navigationTitle("마이페이지")
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
    
    private func cardBackground() -> some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(Color.white)
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    @ViewBuilder
    private var profileCard: some View {
        let emoji = UserProfileManager.shared.getProfileEmoji() ?? "🌸"
        let nickname = UserProfileManager.shared.getNickname() ?? "등대지기"
        let islandName = UserProfileManager.shared.getIslandName() ?? "도마도"
        
        HStack(spacing: 20) {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(LinearGradient.primaryGradient)
                    .frame(width: 100, height: 100)
                
                Text(emoji)
                    .font(.system(size: 50))
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(nickname)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.black)
                
                Text(islandName)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                
                HStack(spacing: 4) {
                    Image("ic_google")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color(hex: "2B7FFF"))
                    
                    Text("Google로 로그인")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                Button(action: {
                    viewModel.editProfile()
                }) {
                    HStack(spacing: 4) {
                        Text("프로필 편집")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color.blue)
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(Color.blue)
                    }
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .padding(.vertical, 10)
        .background(cardBackground())
    }
    
    @ViewBuilder
    private var bookmarkedMessagesCard: some View {
        Button(action: {
            viewModel.showBookmarks()
        }) {
            HStack {
                Image("ic_profile_bookmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)

                Text("북마크한 메시지")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .background(cardBackground())
        }
    }
    
    @ViewBuilder
    private var settingsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("설정")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.gray)
                .padding(.horizontal, 4)
            
            VStack(spacing: 20) {
                HStack {
                    Image("ic_profile_notification")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    
                    Text("알림 설정")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Toggle("", isOn: $isNotificationEnabled)
                        .tint(Color(hex: "2B7FFF"))
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                Divider()
                    .padding(.leading, 60)
                
                Button(action: {
                    viewModel.showPrivacyPolicy()
                }) {
                    HStack {
                        Image("ic_profile_privacy")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)

                        Text("개인정보 처리방침")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 20)
                }
                
                Divider()
                    .padding(.leading, 60)
                
                Button(action: {
                    viewModel.showTermsOfService()
                }) {
                    HStack {
                        Image("ic_profile_terms")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)

                        Text("이용약관")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
            .background(cardBackground())
        }
    }
    
    @ViewBuilder
    private var appVersionCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("앱 버전")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                
                Spacer()
                
                Text("1.0.0")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
            }
            HStack {
                Text("최신 버전입니다")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Spacer()
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .background(cardBackground())
    }
    
    @ViewBuilder
    private var logoutButton: some View {
        Button(action: {
            viewModel.logout()
        }) {
            HStack {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.system(size: 18))
                    .foregroundColor(.red)
                
                Text("로그아웃")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.red)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .background(cardBackground())
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}
