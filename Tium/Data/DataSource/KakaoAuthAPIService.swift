//
//  KakaoAuthAPIService.swift
//  Tium
//
//  Created by JunghyunYoo on 11/04/25.
//

import Foundation

class KakaoAuthAPIService {
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
            throw KakaoAuthError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200:
            return
        case 401:
            throw KakaoAuthError.unauthorized
        case 403:
            throw KakaoAuthError.accessDenied
        case 500:
            throw KakaoAuthError.serverError
        default:
            throw KakaoAuthError.unknown(httpResponse.statusCode)
        }
    }
    
    private func handleResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        try validateResponse(response)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func getKakaoLoginUrl() async throws -> String {
        let url = URL(string: APIConfiguration.Auth.kakaoLoginUrl)!
        var request = createRequest(url: url, method: "GET")
        
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
        
        let responseDTO: KakaoLoginUrlResponseDTO = try handleResponse(data: data, response: response)
        
        guard responseDTO.success, let loginUrl = responseDTO.data?.loginUrl else {
            throw KakaoAuthError.invalidResponse
        }
        
        return loginUrl
    }
    
    func loginWithKakaoCode(code: String) async throws -> KakaoLoginResponseDTO {
        let url = URL(string: APIConfiguration.Auth.login)!
        var request = createRequest(url: url, method: "POST")
        
        let body = ["code": code]
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
        
        let responseDTO: KakaoLoginResponseDTO = try handleResponse(data: data, response: response)
        
        guard responseDTO.success else {
            throw KakaoAuthError.invalidResponse
        }
        
        return responseDTO
    }
    
    func completeSignup(nickname: String) async throws -> KakaoLoginResponseDTO {
        let url = URL(string: APIConfiguration.Auth.signupComplete)!
        var request = createRequest(url: url, method: "POST", requiresAuth: true)
        
        let body = ["nickname": nickname]
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
        
        let responseDTO: KakaoLoginResponseDTO = try handleResponse(data: data, response: response)
        
        guard responseDTO.success else {
            throw KakaoAuthError.invalidResponse
        }
        
        return responseDTO
    }
}

