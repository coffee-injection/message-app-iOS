//
//  GetBookmarkedLettersUseCase.swift
//  Tium
//
//  Created by JunghyunYoo on 10/14/25.
//

import Foundation

class GetBookmarkedLettersUseCase {
    private let repository: LetterRepositoryProtocol
    
    init(repository: LetterRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [Letter] {
        return try await repository.getBookmarkedLetters()
    }
}
