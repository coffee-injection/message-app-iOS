//
//  BookmarkView.swift
//  MIB
//
//  Created by JunghyunYoo on 9/30/25.
//

import SwiftUI

struct BookmarkView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("북마크")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    BookmarkView()
}
