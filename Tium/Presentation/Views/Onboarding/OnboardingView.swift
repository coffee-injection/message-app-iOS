//
//  OnboardingView.swift
//  Tium
//
//  Created by Junyoo on 12/8/25.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @Binding var isOnboardingComplete: Bool
    
    init(isOnboardingComplete: Binding<Bool> = .constant(false)) {
        _isOnboardingComplete = isOnboardingComplete
    }
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(stops: [
                    .init(color: Color(hex: "3B82F6").opacity(0.3), location: 0),
                    .init(color: Color(hex: "000000").opacity(0), location: 1)
                ]),
                center: .topLeading,
                startRadius: 0,
                endRadius: 800
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                TabView(selection: $currentPage) {
                    OnboardingPageView(
                        icon: "ic_wave",
                        title: "바다 위 누군가로 부터\n편지가 도착했어요",
                        description: "떠다니는 유리병 속\n누군가의 이야기가 담겨있어요"
                    )
                    .tag(0)
                    
                    OnboardingPageView(
                        icon: "ic_bottle",
                        title: "마음을 담아\n바다 위로 띄워보세요",
                        description: "알 수 없는 섬으로\n따뜻한 마음을 보내 보세요"
                    )
                    .tag(1)
                    
                    OnboardingPageView(
                        icon: "ic_msg",
                        title: "익명으로 마음을 나누는 공간",
                        description: "서로의 프라이버시를 지키며\n진솔한 이야기를 나눌 수 있어요"
                    )
                    .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .frame(height: 400)
                
                Spacer()
                
                nextButton
                    .padding(.horizontal, 20)
            }
            
            VStack {
                HStack {
                    topBackButton
                        .padding(.leading, 20)
                        .opacity(currentPage > 0 ? 1 : 0)
                        .allowsHitTesting(currentPage > 0)
                    
                    Spacer()
                    
                    skipButton
                        .padding(.trailing, 20)
                }
                .padding(.top, 20)
                .frame(height: 44)
                Spacer()
            }
        }
        .animation(.easeInOut(duration: 0.2), value: currentPage)
    }
    
    @ViewBuilder
    private var topBackButton: some View {
        Button(action: {
            withAnimation {
                currentPage -= 1
            }
        }) {
            Image(systemName: "chevron.left")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
                .frame(width: 44, height: 44)
        }
    }
    
    @ViewBuilder
    private var skipButton: some View {
        Button(action: {
            isOnboardingComplete = true
        }) {
            Text("건너뛰기")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.black.opacity(0.7))
        }
    }
    
    @ViewBuilder
    private var nextButton: some View {
        Button(action: {
            if currentPage < 2 {
                withAnimation {
                    currentPage += 1
                }
            } else {
                isOnboardingComplete = true
            }
        }) {
            HStack {
                Text(currentPage < 2 ? "다음" : "시작하기")
                    .font(.system(size: 16, weight: .semibold))
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(hex: "2B7FFF"),
                        Color(hex: "00B8DB")
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(12)
        }
    }
}

struct OnboardingPageView: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        VStack(spacing: 24) {
            iconView
            
            VStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                Text(description)
                    .font(.system(size: 16))
                    .foregroundColor(.black.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    private var iconView: some View {
        Image(icon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 120, height: 120)
    }
}

#Preview {
    OnboardingView()
}
