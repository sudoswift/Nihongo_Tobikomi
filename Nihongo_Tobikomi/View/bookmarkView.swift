//
//  bookmarkView.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 2023/06/12.
//

import SwiftUI

struct bookmarkView: View {
    @EnvironmentObject var userViewModel: UserViewModel // UserViewModel을 EnvironmentObject로 가져옴
    @Environment(\.presentationMode) var presentationMode // 현재 뷰를 닫을 수 있는 환경 변수
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    HStack {
                        Image(systemName: "clock.arrow.circlepath")
                        Text("履歴")
                        Spacer()
                    } // HStack
                    .padding()
                    
                    HStack {
                        Text("飛び込む")
                        Text("뛰어들다")
                    }
                    
                    HStack {
                        Text("呼び出す")
                        Text("호출하다")
                    }
                } // 履歴VStack
                
                // N1~N2는 List로 만들기
            } // VStack
            .navigationBarTitle("復習", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // 로그아웃 처리
                        userViewModel.signOut()
                        // 현재 뷰를 닫고 로그인 뷰로 이동
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.forward") // 로그아웃 버튼
                    }
                    .tint(.black)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("refresh")
                        // 새로 고침 버튼 로직 추가
                    } label: {
                        Image(systemName: "arrow.clockwise.circle") // 새로 고침 버튼
                    }
                    .tint(.black)
                }
            } // toolbar
        }
    }
}

#Preview {
    bookmarkView()
        .environmentObject(UserViewModel()) // UserViewModel 주입
}
