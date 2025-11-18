//
//  BookmarkViewModel.swift
//  MIB
//
//  Created by JunghyunYoo on 10/14/25.
//

import Foundation
import SwiftUI

@MainActor
class BookmarkViewModel: ObservableObject {
    @Published var letters: [Letter] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let getBookmarkedLettersUseCase: GetBookmarkedLettersUseCase
    
    init(
        getBookmarkedLettersUseCase: GetBookmarkedLettersUseCase,
        deleteLetterUseCase: DeleteLetterUseCase? = nil
    ) {
        self.getBookmarkedLettersUseCase = getBookmarkedLettersUseCase
    }
    
    func loadLetters() async {
        isLoading = true
        errorMessage = nil
        
        do {
            letters = try await getBookmarkedLettersUseCase.execute()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func deleteLetter(id: String) async {
        print("편지 삭제 버튼 클릭됨: \(id)")
    }
    
    func goBack() {
        print("북마크 뒤로가기 버튼 클릭")
    }
    
    func showMenu() {
        print("북마크 메뉴 버튼 클릭")
    }
    
}
