//
//  TokenManager.swift
//  Tium
//
//  Created by JunghyunYoo on 11/11/25.
//

import Foundation

class TokenManager {
    static let shared = TokenManager()
    
    private let accessTokenKey = "access_token"
    private let tokenTypeKey = "token_type"
    private let expiresInKey = "expires_in"
    
    private init() {}
    
    func saveToken(accessToken: String, tokenType: String, expiresIn: Int64) {
        UserDefaults.standard.set(accessToken, forKey: accessTokenKey)
        UserDefaults.standard.set(tokenType, forKey: tokenTypeKey)
        UserDefaults.standard.set(expiresIn, forKey: expiresInKey)
    }
    
    func getAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: accessTokenKey)
    }
    
    func getTokenType() -> String? {
        return UserDefaults.standard.string(forKey: tokenTypeKey) ?? "Bearer"
    }
    
    func getAuthorizationHeader() -> String? {
        guard let token = getAccessToken(),
              let type = getTokenType() else {
            return nil
        }
        return "\(type) \(token)"
    }
    
    func clearToken() {
        UserDefaults.standard.removeObject(forKey: accessTokenKey)
        UserDefaults.standard.removeObject(forKey: tokenTypeKey)
        UserDefaults.standard.removeObject(forKey: expiresInKey)
    }
}

