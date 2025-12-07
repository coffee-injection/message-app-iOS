//
//  LetterDTO.swift
//  Tium
//
//  Created by JunghyunYoo on 10/14/25.
//

import Foundation

struct LetterDTO: Codable {
    let id: Int64
    let content: String
    let status: String
    let sender: MemberDTO
    let receiver: MemberDTO?
    let matchedAt: String?
    let readAt: String?
    let createdAt: String
    let isBookmarked: Bool?
    
    func toDomain() -> Letter {
        return Letter(
            id: String(id),
            content: content,
            status: LetterStatus(rawValue: status) ?? .waiting,
            sender: sender.nickname,
            receiver: receiver?.nickname,
            matchedAt: matchedAt?.toDate(),
            readAt: readAt?.toDate(),
            createdAt: createdAt.toDate()
        )
    }
}

struct MemberDTO: Codable {
    let id: Int64
    let nickname: String
    let email: String
}

extension Letter {
    func toDTO() -> LetterDTO {
        return LetterDTO(
            id: Int64(id) ?? 0,
            content: content,
            status: status.rawValue,
            sender: MemberDTO(id: 0, nickname: sender, email: ""),
            receiver: receiver.map { MemberDTO(id: 0, nickname: $0, email: "") },
            matchedAt: matchedAt?.toISO8601String(),
            readAt: readAt?.toISO8601String(),
            createdAt: createdAt.toISO8601String(),
            isBookmarked: nil
        )
    }
}

