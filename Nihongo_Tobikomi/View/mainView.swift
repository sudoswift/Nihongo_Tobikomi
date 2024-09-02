//
//  mainView.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 2023/06/12.
//

import SwiftUI

struct mainView: View {
    let jlptLevels = ["JLPT_N1", "JLPT_N2", "JLPT_N3", "JLPT_N4", "JLPT_N5"]
    
    private func height(for level: String) -> CGFloat {
        switch level {
        case "JLPT_N1":
            return 180
        case "JLPT_N2":
            return 140
        case "JLPT_N3":
            return 90
        case "JLPT_N4":
            return 60
        case "JLPT_N5":
            return 40
        default:
            return 60 // 기본 높이
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer() // 위쪽 여백을 채우기 위한 Spacer
                
                ScrollView {
                    VStack(spacing: 16) { // 항목 간의 여백 설정
                        ForEach(jlptLevels, id: \.self) { level in
                            NavigationLink(destination: jlptView(level: level)) {
                                Text(level)
                                    .font(.title2)
                                    .frame(maxWidth: .infinity, minHeight: height(for: level)) // 세로 길이 설정
                                    .background(Color.white) // 배경색을 흰색으로 설정
                                    .clipShape(RoundedRectangle(cornerRadius: 8)) // 모서리 둥글게
                                    .overlay( // 테두리 추가
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.black.opacity(0.5), lineWidth: 1) // 테두리 색상 및 두께 설정
                                    )
                                    .padding(.horizontal, 16) // 양쪽에 여백 추가
                            }
                        }
                    }
                    .padding(.vertical, 16) // 상하 여백 추가
                }
                
                Spacer() // 아래쪽 여백을 채우기 위한 Spacer
            }
            .background(Color.white.edgesIgnoringSafeArea(.all)) // 전체 배경색을 흰색으로 설정
            .navigationTitle("ソヒョン")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        print("alarm")
                    } label: {
                        Image(systemName: "bell")
                    }
                    .tint(.black)
                    
                    Button {
                        print("ranking")
                    } label: {
                        Image(systemName: "medal")
                    }
                    .tint(.black)
                    
                    Button {
                        print("setting")
                    } label: {
                        Image(systemName: "gearshape")
                    }
                    .tint(.black)
                }
            }
        }
    }
}

#Preview{
    mainView()
}
