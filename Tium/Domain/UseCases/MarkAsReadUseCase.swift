//
//  MarkAsReadUseCase.swift
//  Tium
//
//  Created by JunghyunYoo on 10/14/25.
//

import Foundation

class MarkAsReadUseCase {
    private let repository: LetterRepositoryProtocol
    
    init(repository: LetterRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(letterId: String) async throws {
        let letter = try await repository.getLetter(id: letterId)
        
        guard letter.canBeRead else {
            throw LetterError.cannotReadLetter
        }
        
        try await repository.markAsRead(id: letterId)
    }
}
