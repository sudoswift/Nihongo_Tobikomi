//
//  ContentView.swift
//  Nihongo_Tobikomi
//
//  Created by ioio on 2023/06/12.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var userViewModel = UserViewModel()
    
    var body: some View {
        if userViewModel.user != nil{
            //userViewModel.user가 로그인 되어 있을 때
            TabView {
                mainView()
                    .tabItem {
                        Label("学習", systemImage: "list.bullet.rectangle.portrait.fill")
                    }
                bookmarkView()
                    .tabItem {
                        Label("復習", systemImage: "book.fill")
                    }
            }
        } else {
            //userViewModel.user가 로그인 되어 있지 않을 때
            signInView()
        }

    }
}

#Preview {
    ContentView()
}
