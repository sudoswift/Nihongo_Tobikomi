//
//  bookmarkView.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 2023/06/12.
//

import SwiftUI

struct bookmarkView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @StateObject private var learnViewModel = LearnViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            VStack {
                // 상단 헤더
                HStack {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("履歴") // 일본어 텍스트
                    Spacer()
                }
                .padding()
                
                // 북마크된 단어를 보여주는 ScrollView와 ForEach
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(learnViewModel.bookmarkedWords) { word in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(word.jpn)
                                        .font(.headline)
                                    Text(word.kr)
                                        .font(.subheadline)
                                }
                                Spacer()
                                HStack {
                                    Text(word.grade)
                                        .font(.footnote)
                                        .foregroundColor(.black)
                                        .padding(8)
                                        .background(color(for: word.grade))
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    Text("기출년도: \(word.testYear)")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.vertical, 8)
                }
                .background(Color.white.edgesIgnoringSafeArea(.all))
                .onAppear {
                    learnViewModel.fetchBookmarkedWords() // 모든 북마크된 단어를 가져옵니다
                }
            }
            .navigationBarTitle("북마크", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        userViewModel.signOut()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.forward")
                    }
                    .tint(.black)
                }
            }
        }
    }
    
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
}

#Preview {
    bookmarkView()
        .environmentObject(UserViewModel()) // UserViewModel 주입
}
