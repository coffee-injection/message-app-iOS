//
//  LetterRepository.swift
//  MIB
//
//  Created by JunghyunYoo on 10/14/25.
//

import Foundation

class LetterRepository: LetterRepositoryProtocol {
    private let apiService: LetterAPIService
    
    init(apiService: LetterAPIService) {
        self.apiService = apiService
    }
    
    func getMyLetters() async throws -> [Letter] {
        let letterDTOs = try await apiService.getLetterList()
        return letterDTOs.map { $0.toDomain() }
    }
    
    func getReadableLetters() async throws -> [Letter] {
        let letterDTOs = try await apiService.getLetterList()
        return letterDTOs.map { $0.toDomain() }
    }
    
    func getBookmarkedLetters() async throws -> [Letter] {
        let letterDTOs = try await apiService.getLetterList()
        return letterDTOs.filter { $0.isBookmarked == true }.map { $0.toDomain() }
    }
    
    func getLetter(id: String) async throws -> Letter {
        let letterDTO = try await apiService.getLetterDetail()
        return letterDTO.toDomain()
    }
    
    func sendLetter(content: String) async throws -> Letter {
        let letterDTO = try await apiService.sendLetter(content: content)
        return letterDTO.toDomain()
    }
    
    func markAsRead(id: String) async throws {
        // 협의?
    }
    
    func bookmarkLetter(id: String) async throws {
        try await apiService.bookmarkLetter()
    }
    
    func unbookmarkLetter(id: String) async throws {
        // 협의?
    }
    
    func deleteLetter(id: String) async throws {
        // 협의?
    }
    
    func reportLetter(id: String) async throws {
        try await apiService.reportLetter()
    }
}
