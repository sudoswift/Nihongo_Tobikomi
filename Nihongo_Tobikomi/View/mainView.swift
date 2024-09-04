//
//  mainView.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 2023/06/12.
//

import SwiftUI

struct mainView: View {
    @EnvironmentObject var userViewModel: UserViewModel // UserViewModel을 EnvironmentObject로 가져옴

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

    @Environment(\.presentationMode) var presentationMode // 현재 뷰를 닫을 수 있는 환경 변수

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
            .navigationTitle(userViewModel.user?.userName ?? "ソヒョン") // 로그인한 사용자 이름 또는 기본 제목
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
                        userViewModel.signOut() // 로그아웃 처리
                        presentationMode.wrappedValue.dismiss() // 현재 뷰 닫기
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
        .onAppear {
            // 로그아웃 후 로그인 뷰로 이동하기 위한 로직 추가
            if userViewModel.user == nil {
                DispatchQueue.main.async {
                    // 현재 뷰를 닫고 로그인 뷰로 이동
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

#Preview {
    mainView()
}
