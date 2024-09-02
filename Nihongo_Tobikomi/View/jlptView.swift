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
            return Color.mint // N1의 색상
        case "N2":
            return Color.orange // N2의 색상
        case "N3":
            return Color.gray // N3의 색상
        case "N4":
            return Color.green // N4의 색상
        case "N5":
            return Color.yellow // N5의 색상
        default:
            return Color.yellow // 기본 색상
        }
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                ScrollView {
                    VStack(spacing: 8) { // 항목 간의 여백 설정
                        ForEach(learnViewModel.words) { word in
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text(word.grade)
                                        .font(.footnote)
                                        .foregroundColor(.black)
                                        .padding(8)
                                        .background(color(for: word.grade)) // grade에 따른 색상 설정
                                        .clipShape(RoundedRectangle(cornerRadius: 8)) // 모서리 둥글게
                                    Spacer()
                                    Text("기출년도: \(word.testYear)")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                                Text(word.jpn)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .center) // 중앙 정렬
                                Text(word.kr)
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity, alignment: .center) // 중앙 정렬
                            }
                            .padding()
                            .background(Color.white) // 각 항목의 배경색을 흰색으로 설정
                            .clipShape(RoundedRectangle(cornerRadius: 8)) // 모서리 둥글게
                            .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2) // 그림자 추가
                            .padding(.horizontal, 16) // 양쪽에 여백 추가
                            .frame(maxWidth: .infinity, minHeight: 100) // 세로 길이 조정
                        }
                    }
                    .padding(.vertical, 8) // ScrollView의 상하 여백 추가
                }
                .background(Color.white.edgesIgnoringSafeArea(.all)) // ScrollView의 배경색을 흰색으로 설정
                .onAppear {
                    learnViewModel.fetchWords(for: level)
                }
                .navigationTitle(level)
            }
            
            // Floating Action Button
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
            .padding() // 화면 가장자리와의 간격 조정
        }
        .background(Color.white.edgesIgnoringSafeArea(.all)) // 전체 배경색을 흰색으로 설정
    }
}


#Preview {
    jlptView(level: "JLPT_N1")
}
