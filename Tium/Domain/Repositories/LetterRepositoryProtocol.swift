//
//  LetterRepositoryProtocol.swift
//  Tium
//
//  Created by JunghyunYoo on 10/14/25.
//

import Foundation

protocol LetterRepositoryProtocol {
    func getMyLetters() async throws -> [Letter]
    func getReadableLetters() async throws -> [Letter]
    func getBookmarkedLetters() async throws -> [Letter]
    func getLetter(id: String) async throws -> Letter
    func sendLetter(content: String) async throws -> Letter
    func markAsRead(id: String) async throws
    func bookmarkLetter(id: String) async throws
    func unbookmarkLetter(id: String) async throws
    func deleteLetter(id: String) async throws
    func reportLetter(id: String) async throws
}
