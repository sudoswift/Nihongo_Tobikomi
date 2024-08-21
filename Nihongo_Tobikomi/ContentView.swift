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
                    Label("学習", systemImage: "list.bullet.rectangle.portrait.fill")// list.dash
                }
            bookmarkView()
                .tabItem {
                    Label("復習", systemImage: "book.fill")
                }
        }//TabView
    }
}

#Preview {
    ContentView()
}
