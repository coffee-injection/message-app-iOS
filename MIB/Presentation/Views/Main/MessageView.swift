//
//  MessageView.swift
//  MIB
//
//  Created by JunghyunYoo on 10/26/25.
//

import SwiftUI

struct MessageView: View {
    let message: String
    let onDismiss: () -> Void
    
    var body: some View {
        letterImage
            .overlay(overlayContent)
    }
    
    // MARK: - View Builders
    
    @ViewBuilder
    private var letterImage: some View {
        Image("letter")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 400)
    }
    
    @ViewBuilder
    private var overlayContent: some View {
        VStack {
            headerRow
            Spacer()
            messageScrollView
        }
    }
    
    @ViewBuilder
    private var headerRow: some View {
        HStack {
            Text("제목?")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Spacer()
            
            CloseButton(action: onDismiss, size: 24, weight: .bold)
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
    
    @ViewBuilder
    private var messageScrollView: some View {
        ScrollView {
            Text(message)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 40)
                .padding(.vertical, 20)
        }
    }
}

#Preview {
    MessageView(message: "안녕하세요! 날씨가좋네요", onDismiss: {})
}
