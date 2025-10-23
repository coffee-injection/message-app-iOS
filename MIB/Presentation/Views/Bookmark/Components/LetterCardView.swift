//
//  LetterCardView.swift
//  MIB
//
//  Created by JunghyunYoo on 10/14/25.
//

import SwiftUI

struct LetterCardView: View {
    let letter: Letter
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: statusIcon)
                .font(.system(size: 40))
                .foregroundColor(statusColor)
                .frame(width: 60, height: 60)
                .background(Color.white)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(letter.content)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .lineLimit(2)
                
                Text("From: \(letter.sender)")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                if let readAt = letter.readAt {
                    Text("읽은 시간: \(readAt.formatted(date: .abbreviated, time: .shortened))")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            Button(action: onDelete) {
                Image(systemName: "trash")
                    .font(.title3)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color(red: 0.94, green: 0.96, blue: 0.98))
        .cornerRadius(12)
    }
    
    private var statusIcon: String {
        switch letter.status {
        case .waiting: return "clock"
        case .delivered: return "envelope.open"
        case .read: return "envelope.open.fill"
        }
    }
    
    private var statusColor: Color {
        switch letter.status {
        case .waiting: return .orange
        case .delivered: return .blue
        case .read: return .green
        }
    }
}

#Preview {
    LetterCardView(letter: Letter.sampleLetters[0], onDelete: {})
}
