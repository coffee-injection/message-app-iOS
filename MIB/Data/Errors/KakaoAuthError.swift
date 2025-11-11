//
//  KakaoAuthError.swift
//  MIB
//
//  Created by JunghyunYoo on 11/11/25.
//

import Foundation

enum KakaoAuthError: Error, LocalizedError {
    case invalidResponse
    case unauthorized
    case accessDenied
    case serverError
    case unknown(Int)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "유효하지 않은 응답입니다."
        case .unauthorized:
            return "인증이 필요합니다."
        case .accessDenied:
            return "접근 권한이 없습니다."
        case .serverError:
            return "서버 내부 오류가 발생했습니다."
        case .unknown(let code):
            return "알 수 없는 오류가 발생했습니다. (코드: \(code))"
        }
    }
}

