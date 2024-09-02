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

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                ScrollView {
                    VStack(spacing: 8) { // 항목 간의 여백 설정
                        ForEach(learnViewModel.words) { word in
                            VStack(alignment: .leading, spacing: 10) {
                                Text(word.jpn)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .center) // 중앙 정렬
                                Text(word.kr)
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity, alignment: .center) // 중앙 정렬
                                Text("급수: \(word.grade) | 기출년도: \(word.testYear)")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
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
            .sheet(isPresented: $showAddWordView) {
                addWordView(level: level)
                    .environmentObject(learnViewModel)
            }
            .padding() // 화면 가장자리와의 간격 조정
        }
        .background(Color(UIColor.systemGray6).edgesIgnoringSafeArea(.all)) // List의 배경색을 회색으로 설정
    }
}


#Preview {
    jlptView(level: "JLPT_N1")
}
