//
//  mainView.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 2023/06/12.
//

import SwiftUI

struct mainView: View {
    @StateObject private var learnViewModel = LearnViewModel()
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(learnViewModel.jlptLevels, id: \.self){ level in
                    NavigationLink(destination: jlptView(level: level)){
                        Text(level)
                    }
                }
            }//List
            .listStyle(.inset)
                .navigationTitle("ソヒョン")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing){
                        Button {
                            print("alaram")
                        } label: {
                            Image(systemName: "bell")
                        } //alaram Button
                        .tint(.black)
                        Button {
                            print("ranking")
                        } label: {
                            Image(systemName: "medal")
                        } //ranking Button
                        .tint(.black)
                        Button {
                            print("setting")
                        } label: {
                            Image(systemName: "gearshape")
                        } //setting Button & sheetView 예정
                        .tint(.black)
                    }
                }//toolbar
        }//NavigationStack
    }
}

#Preview{
    mainView()
}
