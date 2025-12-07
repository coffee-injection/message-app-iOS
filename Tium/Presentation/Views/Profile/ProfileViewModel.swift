//
//  ProfileViewModel.swift
//  Tium
//
//  Created by JunghyunYoo on 10/14/25.
//

import Foundation
import SwiftUI

@MainActor
class ProfileViewModel: ObservableObject {
    
    func editProfile() {
        print("프로필 편집 버튼 클릭")
    }
    
    func showBookmarks() {
        print("북마크 메뉴 버튼 클릭")
    }
    
    func showSettings() {
        print("설정 메뉴 버튼 클릭")
    }
    
    func logout() {
        print("로그아웃 버튼 클릭")
    }
    
    func goBack() {
        print("뒤로가기 버튼 클릭")
    }
}
