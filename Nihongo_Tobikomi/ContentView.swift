//
//  ContentView.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 2023/06/12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            mainView()
                .tabItem {
                    Label("ナウ", systemImage: "list.dash")
                }
            bookmarkView()
                .tabItem {
                    Label("お気に入り", systemImage: "book.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
