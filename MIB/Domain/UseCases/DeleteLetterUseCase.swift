//
//  DeleteLetterUseCase.swift
//  MIB
//
//  Created by JunghyunYoo on 10/14/25.
//

import Foundation

class DeleteLetterUseCase {
    private let repository: LetterRepositoryProtocol
    
    init(repository: LetterRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(letterId: String) async throws {
        try await repository.deleteLetter(id: letterId)
    }
}
