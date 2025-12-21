//
//  UserProfileManager.swift
//  Tium
//
//  Created by Junyoo on 12/21/25.
//

import Foundation

class UserProfileManager {
    static let shared = UserProfileManager()
    
    private let profileEmojiKey = "profile_emoji"
    private let islandNameKey = "island_name"
    private let categoryTypeKey = "category_type"
    private let nicknameKey = "nickname"
    
    private init() {}
    
    func saveProfile(
        emoji: String,
        islandName: String,
        categoryType: String,
        nickname: String
    ) {
        UserDefaults.standard.set(emoji, forKey: profileEmojiKey)
        UserDefaults.standard.set(islandName, forKey: islandNameKey)
        UserDefaults.standard.set(categoryType, forKey: categoryTypeKey)
        UserDefaults.standard.set(nickname, forKey: nicknameKey)
    }
    
    func getProfileEmoji() -> String? {
        return UserDefaults.standard.string(forKey: profileEmojiKey)
    }
    
    func getIslandName() -> String? {
        return UserDefaults.standard.string(forKey: islandNameKey)
    }
    
    func getCategoryType() -> String? {
        return UserDefaults.standard.string(forKey: categoryTypeKey)
    }
    
    func getNickname() -> String? {
        return UserDefaults.standard.string(forKey: nicknameKey)
    }
    
    func clearProfile() {
        UserDefaults.standard.removeObject(forKey: profileEmojiKey)
        UserDefaults.standard.removeObject(forKey: islandNameKey)
        UserDefaults.standard.removeObject(forKey: categoryTypeKey)
        UserDefaults.standard.removeObject(forKey: nicknameKey)
    }
}

