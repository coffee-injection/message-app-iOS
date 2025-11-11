//
//  APIConfiguration.swift
//  MIB
//
//  Created by JunghyunYoo on 11/04/25.
//

import Foundation

enum APIConfiguration {
    static let baseURL: String = {
        return "https://server.com" //서버 주소 변경 필요
    }()
    
    // MARK: - API Endpoints
    enum Auth {
        static let kakaoLoginUrl = "\(baseURL)/api/v1/auth/kakao/login-url"
        static let login = "\(baseURL)/api/v1/auth/login"
        static let signupComplete = "\(baseURL)/api/v1/auth/signup/complete"
    }
    
    enum Letter {
        static let list = "\(baseURL)/api/v1/letter/list"
        static let send = "\(baseURL)/api/v1/letter/send"
        static let detail = "\(baseURL)/api/v1/letter/detail"
        static let bookmark = "\(baseURL)/api/v1/letter/book-mark"
    }
    
    enum Report {
        static let report = "\(baseURL)/api/v1/report"
    }
}

