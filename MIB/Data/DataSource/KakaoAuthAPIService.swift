//
//  KakaoAuthAPIService.swift
//  MIB
//
//  Created by JunghyunYoo on 11/04/25.
//

import Foundation

class KakaoAuthAPIService {
    private let session = URLSession.shared
    
    private func createRequest(url: URL, method: String = "GET") -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
        return request
    }
    
    func getKakaoLoginUrl() async throws -> String {
        let url = URL(string: APIConfiguration.Auth.kakaoLoginUrl)!
        var request = createRequest(url: url, method: "GET")
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw KakaoAuthError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200:
            let responseDTO = try JSONDecoder().decode(KakaoLoginUrlResponseDTO.self, from: data)
            
            guard responseDTO.success, let loginUrl = responseDTO.data?.loginUrl else {
                throw KakaoAuthError.invalidResponse
            }
            
            return loginUrl
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
    
    func loginWithKakaoCode(code: String) async throws -> KakaoLoginResponseDTO {
        let url = URL(string: APIConfiguration.Auth.login)!
        var request = createRequest(url: url, method: "POST")
        
        let body = ["code": code]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw KakaoAuthError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200:
            let responseDTO = try JSONDecoder().decode(KakaoLoginResponseDTO.self, from: data)
            
            guard responseDTO.success else {
                throw KakaoAuthError.invalidResponse
            }
            
            return responseDTO
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
}

