//
//  SendLetterUseCase.swift
//  MIB
//
//  Created by JunghyunYoo on 10/14/25.
//

import Foundation

class SendLetterUseCase {
    private let repository: LetterRepositoryProtocol
    
    init(repository: LetterRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(content: String) async throws -> Letter {
        guard !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw LetterError.emptyContent
        }
        
        guard content.count <= 1000 else {
            throw LetterError.contentTooLong
        }
        
        return try await repository.sendLetter(content: content)
    }
}

enum LetterError: Error, LocalizedError {
    case emptyContent
    case contentTooLong
    case cannotReadLetter
    case mustReadFirst
    case alreadyBookmarked
    
    var errorDescription: String? {
        switch self {
        case .emptyContent:
            return "편지 내용을 입력해주세요."
        case .contentTooLong:
            return "편지 내용이 너무 깁니다. (최대 1000자)"
        case .cannotReadLetter:
            return "읽을 수 없는 편지입니다."
        case .mustReadFirst:
            return "읽은 편지만 북마크할 수 있습니다."
        case .alreadyBookmarked:
            return "이미 북마크된 편지입니다."
        }
    }
}
