//
//  mainView.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 2023/06/12.
//

import SwiftUI

struct mainView: View {
    var body: some View {
        NavigationStack {
            List{
                Text("JLPT N1")
                Text("JLPT N2")
                Text("JLPT N3")
                Text("JLPT N4")
                Text("JLPT N5")
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

struct mainView_Previews: PreviewProvider {
    static var previews: some View {
        mainView()
    }
}
