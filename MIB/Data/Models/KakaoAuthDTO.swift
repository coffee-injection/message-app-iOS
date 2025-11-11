//
//  KakaoAuthDTO.swift
//  MIB
//
//  Created by JunghyunYoo on 11/11/25.
//

import Foundation

struct KakaoLoginUrlResponseDTO: Codable {
    let status: Int
    let data: KakaoLoginUrlDataDTO?
    let success: Bool
    let timeStamp: String
}

struct KakaoLoginUrlDataDTO: Codable {
    let loginUrl: String
}

struct KakaoLoginResponseDTO: Codable {
    let status: Int
    let data: KakaoLoginDataDTO?
    let success: Bool
    let timeStamp: String
}

struct KakaoLoginDataDTO: Codable {
    let token: String?
    let refreshToken: String?
    let isNewMember: Bool?
}
