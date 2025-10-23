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
    private let deleteLetterUseCase: DeleteLetterUseCase
    
    init(
        getBookmarkedLettersUseCase: GetBookmarkedLettersUseCase,
        deleteLetterUseCase: DeleteLetterUseCase
    ) {
        self.getBookmarkedLettersUseCase = getBookmarkedLettersUseCase
        self.deleteLetterUseCase = deleteLetterUseCase
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
        do {
            try await deleteLetterUseCase.execute(letterId: id)
            await loadLetters()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func goBack() {
        print("북마크 뒤로가기 버튼 클릭")
    }
    
    func showMenu() {
        print("북마크 메뉴 버튼 클릭")
    }
    
}
