//
//  BookmarkView.swift
//  MIB
//
//  Created by JunghyunYoo on 9/30/25.
//

import SwiftUI

struct BookmarkView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = BookmarkViewModel(
        getBookmarkedLettersUseCase: GetBookmarkedLettersUseCase(repository: LetterRepository(apiService: LetterAPIService())),
        deleteLetterUseCase: DeleteLetterUseCase(repository: LetterRepository(apiService: LetterAPIService()))
    )
    
    var body: some View {
        ZStack {
            Color(red: 0.87, green: 0.92, blue: 0.97)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(Letter.sampleLetters, id: \.id) { letter in
                            LetterCardView(
                                letter: letter,
                                onDelete: {
                                    Task {
                                        await viewModel.deleteLetter(id: letter.id)
                                    }
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                }
            }
        }
        .navigationTitle("북마크")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    viewModel.goBack()
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.showMenu()
                }) {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(.black)
                }
            }
        }
    }
}


#Preview {
    BookmarkView()
}
