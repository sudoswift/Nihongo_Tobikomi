//
//  bookmarkView.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 2023/06/12.
//

import SwiftUI

struct bookmarkView: View {
    var body: some View {
        NavigationStack {
            VStack{
                VStack {
                    HStack {
                        Image(systemName: "clock.arrow.circlepath")
                        Text("履歴")
                        Spacer()
                    }//HStack
                    .padding()
                    HStack{
                        Text("飛び込む")
                        Text("뛰어들다")
                    }
                    HStack{
                        Text("呼び出す")
                        Text("호출하다")
                    }
                }//履歴VStack
                // N1~N2 는 List로 만들기
            }//VStack
            .navigationBarTitle("復習", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        print("setting")
                    } label: {
                        Image(systemName: "gearshape")
                    } //setting Button & sheetView 예정
                    .tint(.black)
                }
                ToolbarItem(placement: .navigationBarLeading){
                    Button {
                        print("setting")
                    } label: {
                        Image(systemName: "arrow.clockwise.circle")
                    } //setting Button & sheetView 예정
                    //flame버튼을 새로고침 버튼으로 만들계획, 누르면 이력 단어 중 1개가 나옴
                    .tint(.black)
                }
            }//toolbar
        }
    }
}

#Preview {
    bookmarkView()
}
