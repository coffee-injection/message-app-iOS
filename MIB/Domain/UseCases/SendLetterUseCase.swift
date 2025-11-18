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
    case unauthorized
    case accessDenied
    case serverError
    case invalidResponse
    case unknown(Int)
    
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
        case .unauthorized:
            return "인증이 필요합니다."
        case .accessDenied:
            return "접근 권한이 없습니다."
        case .serverError:
            return "서버 내부 오류가 발생했습니다."
        case .invalidResponse:
            return "유효하지 않은 응답입니다."
        case .unknown(let code):
            return "알 수 없는 오류가 발생했습니다. (코드: \(code))"
        }
    }
}
