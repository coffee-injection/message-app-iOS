//
//  PermissionGuideView.swift
//  Tium
//
//  Created by Junyoo on 12/16/25.
//

import SwiftUI

struct PermissionGuideView: View {
    let onAgree: () -> Void
    let onDismiss: (() -> Void)?
    
    init(onAgree: @escaping () -> Void, onDismiss: (() -> Void)? = nil) {
        self.onAgree = onAgree
        self.onDismiss = onDismiss
    }
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                cardView
                
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private var cardView: some View {
        VStack(spacing: 0) {
            headerSection
                .padding(.top, 32)
            
            contentSection
                .padding(.top, 32)
                .padding(.horizontal, 24)
            
            actionSection
                .padding(.top, 32)
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private var headerSection: some View {
        VStack(spacing: 16) {
            Image("ic_bell")
                .resizable()
                .frame(width: 80, height: 80)
            
            Text("알림 및 권한 안내")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
        }
    }
    
    @ViewBuilder
    private var contentSection: some View {
        VStack(spacing: 20) {
            permissionItem(
                icon: "ic_bell",
                iconBackgroundColor: Color(hex: "2B7FFF").opacity(0.2),
                iconColor: Color(hex: "FFD700"),
                title: "알림 권한",
                description: "새로운 메시지 보틀이 도착하면 알려 드립니다"
            )
            
            permissionItem(
                icon: "ic_lock",
                iconBackgroundColor: Color(hex: "4CAF50").opacity(0.2),
                iconColor: Color(hex: "FFD700"),
                title: "개인정보 보호",
                description: "최소한의 정보만 수집하며 안전하게 보관됩니다"
            )
        }
    }
    
    @ViewBuilder
    private func permissionItem(
        icon: String,
        iconBackgroundColor: Color,
        iconColor: Color,
        title: String,
        description: String
    ) -> some View {
        HStack(alignment: .top, spacing: 16) {
            ZStack {
                Circle()
                    .fill(iconBackgroundColor)
                    .frame(width: 48, height: 48)
                
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.black)
                
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(.black.opacity(0.7))
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private var actionSection: some View {
        VStack(spacing: 12) {
            Button(action: {
                onAgree()
            }) {
                Text("동의하고 시작하기")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(LinearGradient.primaryGradient)
                    .cornerRadius(12)
            }
            
            Text("개인정보 처리방침 및 이용약관에 동의합니다")
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    PermissionGuideView(onAgree: {}, onDismiss: {})
}

