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
            Text("お気に入り")
                .navigationBarTitle("お気に入り", displayMode: .inline)
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
                            Image(systemName: "flame")
                        } //setting Button & sheetView 예정
                        .tint(.black)
                    }
                }//toolbar
        }
    }
}

struct bookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        bookmarkView()
    }
}
