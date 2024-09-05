//
//  jlptView.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 8/17/24.
//

import SwiftUI

struct jlptView: View {
    var level: String
    @StateObject private var learnViewModel = LearnViewModel()
    @State private var showAddWordView = false

    private func color(for grade: String) -> Color {
        switch grade {
        case "N1":
            return Color.mint
        case "N2":
            return Color.orange
        case "N3":
            return Color.gray
        case "N4":
            return Color.green
        case "N5":
            return Color.yellow
        default:
            return Color.yellow
        }
    }
    
    private func bookmarkButton(for word: Learn) -> some View {
        let isBookmarked = learnViewModel.bookmarkedWords.contains(where: { $0.id == word.id })
        let imageName = isBookmarked ? "star.fill" : "star"
        let color: Color = isBookmarked ? .yellow : .gray

        return Button(action: {
            learnViewModel.toggleBookmark(for: word)
        }) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(color)
        }
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(learnViewModel.words) { word in
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text(word.grade)
                                        .font(.footnote)
                                        .foregroundColor(.black)
                                        .padding(8)
                                        .background(color(for: word.grade))
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    Spacer()
                                    Text("기출년도: \(word.testYear)")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                                Text(word.jpn)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Text(word.kr)
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                
                                // 북마크 버튼
                                HStack {
                                    Spacer()
                                    bookmarkButton(for: word) // 매개변수로 word 전달
                                }
                                .padding(.top, 8)
                            }
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity, minHeight: 100)
                        }
                    }
                    .padding(.vertical, 8)
                }
                .background(Color.white.edgesIgnoringSafeArea(.all))
                .onAppear {
                    learnViewModel.fetchWords(for: level)
                    learnViewModel.fetchBookmarkedWords(for: level)
                }
                .navigationTitle(level)
            }
            
            Button(action: {
                showAddWordView.toggle()
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.blue)
                    .padding()
            }
            .fullScreenCover(isPresented: $showAddWordView) {
                addWordView(level: level)
                    .environmentObject(learnViewModel)
            }
            .padding()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    jlptView(level: "JLPT_N1")
}
