//
//  LetterAPIService.swift
//  MIB
//
//  Created by JunghyunYoo on 10/14/25.
//

import Foundation

class LetterAPIService {
    private let baseURL = ""
    private let session = URLSession.shared
    
    func getLetterList() async throws -> [LetterDTO] {
        let url = URL(string: "\(baseURL)/letter/list")!
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode([LetterDTO].self, from: data)
    }
    
    func sendLetter(content: String) async throws -> LetterDTO {
        let url = URL(string: "\(baseURL)/letter/send")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["content": content]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, _) = try await session.data(for: request)
        return try JSONDecoder().decode(LetterDTO.self, from: data)
    }
    
    func getLetterDetail() async throws -> LetterDTO {
        let url = URL(string: "\(baseURL)/letter/detail")!
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode(LetterDTO.self, from: data)
    }
    
    func bookmarkLetter() async throws {
        let url = URL(string: "\(baseURL)/letter/book-mark")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let (_, _) = try await session.data(for: request)
    }
}
