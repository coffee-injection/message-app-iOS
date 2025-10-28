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
        Image("letter")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 400)
            .overlay(
                VStack {
                    HStack {
                        Text("제목?")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button(action: {
                            onDismiss()
                        }) {
                            Image(systemName: "xmark")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    Spacer()
                    
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
            )
    }
}

#Preview {
    MessageView(message: "안녕하세요! 날씨가좋네요", onDismiss: {})
}
