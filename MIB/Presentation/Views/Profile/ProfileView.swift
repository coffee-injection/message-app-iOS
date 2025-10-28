//
//  ProfileView.swift
//  MIB
//
//  Created by JunghyunYoo on 9/30/25.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        ZStack {
            Color(red: 0.95, green: 0.97, blue: 1.0)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                VStack(spacing: 16) {
                    ZStack {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 100))
                            .foregroundColor(.gray.opacity(0.3))
                        
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Button(action: {
                                    viewModel.editProfile()
                                }) {
                                    Image(systemName: "pencil")
                                        .font(.system(size: 12))
                                        .foregroundColor(.white)
                                        .frame(width: 24, height: 24)
                                        .background(Color.blue)
                                        .clipShape(Circle())
                                }
                            }
                        }
                        .frame(width: 100, height: 100)
                    }
                    
                    Text("Ethan")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Text("@ethan_sea")
                        .font(.body)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(spacing: 12) {
                    Button(action: {
                        viewModel.showBookmarks()
                    }) {
                        HStack {
                            Image(systemName: "bookmark")
                                .font(.title2)
                                .foregroundColor(.black)
                            
                            Text("Bookmarks")
                                .font(.body)
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    }
                    
                    Button(action: {
                        viewModel.showSettings()
                    }) {
                        HStack {
                            Image(systemName: "gearshape")
                                .font(.title2)
                                .foregroundColor(.black)
                            
                            Text("Settings")
                                .font(.body)
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.logout()
                }) {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .font(.title2)
                            .foregroundColor(.black)
                        
                        Text("Logout")
                            .font(.body)
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
                }
                
                Text("Version 1.0.0")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.bottom, 20)
            }
        }
        .navigationTitle("My Page")
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
        }
    }
}

#Preview {
    ProfileView()
}
