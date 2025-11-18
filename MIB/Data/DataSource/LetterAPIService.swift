//
//  LetterAPIService.swift
//  MIB
//
//  Created by JunghyunYoo on 10/14/25.
//

import Foundation

struct APIResponseDTO<T: Decodable>: Decodable {
    let status: Int
    let data: T?
    let success: Bool
    let timeStamp: String
}

class LetterAPIService {
    private let session = URLSession.shared
    
    private func createRequest(url: URL, method: String = "GET", requiresAuth: Bool = false) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if requiresAuth, let authHeader = TokenManager.shared.getAuthorizationHeader() {
            request.setValue(authHeader, forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
    
    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw LetterError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200:
            return
        case 401:
            throw LetterError.unauthorized
        case 403:
            throw LetterError.accessDenied
        case 500:
            throw LetterError.serverError
        default:
            throw LetterError.unknown(httpResponse.statusCode)
        }
    }
    
    private func handleResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        try validateResponse(response)
        let decoder = JSONDecoder()
        let wrappedResponse = try decoder.decode(APIResponseDTO<T>.self, from: data)
        
        guard wrappedResponse.success, let responseData = wrappedResponse.data else {
            throw LetterError.invalidResponse
        }
        
        return responseData
    }
    
    func getLetterList() async throws -> [LetterDTO] {
        let url = URL(string: APIConfiguration.Letter.list)!
        var request = createRequest(url: url, method: "GET", requiresAuth: true)
        
        print("[API Request] GET \(url.absoluteString)")
        print("Headers: \(request.allHTTPHeaderFields ?? [:])")
        print("Body: 없음")
        
        let (data, response) = try await session.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("[API Response] GET \(url.absoluteString)")
            print("Status Code: \(httpResponse.statusCode)")
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response Body: \(responseString)")
            }
        }
        
        return try handleResponse(data: data, response: response)
    }
    
    func sendLetter(content: String) async throws -> LetterDTO {
        let url = URL(string: APIConfiguration.Letter.send)!
        var request = createRequest(url: url, method: "POST", requiresAuth: true)
        
        let body = ["content": content]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        print("[API Request] POST \(url.absoluteString)")
        print("Headers: \(request.allHTTPHeaderFields ?? [:])")
        if let bodyData = request.httpBody,
           let bodyString = String(data: bodyData, encoding: .utf8) {
            print("Body: \(bodyString)")
        }
        
        let (data, response) = try await session.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("[API Response] POST \(url.absoluteString)")
            print("Status Code: \(httpResponse.statusCode)")
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response Body: \(responseString)")
            }
        }
        
        return try handleResponse(data: data, response: response)
    }
    
    func getLetterDetail() async throws -> LetterDTO {
        let url = URL(string: APIConfiguration.Letter.detail)!
        var request = createRequest(url: url, method: "GET", requiresAuth: true)
        
        print("[API Request] GET \(url.absoluteString)")
        print("Headers: \(request.allHTTPHeaderFields ?? [:])")
        print("Body: 없음")
        
        let (data, response) = try await session.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("[API Response] GET \(url.absoluteString)")
            print("Status Code: \(httpResponse.statusCode)")
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response Body: \(responseString)")
            }
        }
        
        return try handleResponse(data: data, response: response)
    }
    
    func bookmarkLetter() async throws {
        let url = URL(string: APIConfiguration.Letter.bookmark)!
        var request = createRequest(url: url, method: "POST", requiresAuth: true)
        
        print("[API Request] POST \(url.absoluteString)")
        print("Headers: \(request.allHTTPHeaderFields ?? [:])")
        print("Body: 없음")
        
        let (data, response) = try await session.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("[API Response] POST \(url.absoluteString)")
            print("Status Code: \(httpResponse.statusCode)")
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response Body: \(responseString)")
            }
        }
        
        try validateResponse(response)
    }
    
    func reportLetter() async throws {
        let url = URL(string: APIConfiguration.Report.report)!
        var request = createRequest(url: url, method: "POST", requiresAuth: true)
        
        print("[API Request] POST \(url.absoluteString)")
        print("Headers: \(request.allHTTPHeaderFields ?? [:])")
        print("Body: 없음")
        
        let (data, response) = try await session.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("[API Response] POST \(url.absoluteString)")
            print("Status Code: \(httpResponse.statusCode)")
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response Body: \(responseString)")
            }
        }
        
        try validateResponse(response)
    }
}
